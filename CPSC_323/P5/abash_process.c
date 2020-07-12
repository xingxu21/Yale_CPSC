#include "abash_process.h"
#include "abash_parse.h"
#include "abash_lex.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <errno.h>
#include <signal.h>
#include <stdbool.h>
#include <sys/file.h>
#include <sys/wait.h>
#include <linux/limits.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <assert.h>


CMD* rotate_command(CMD *current){
	CMD* origional_right =  NULL;

	if (current == NULL)
	{
		return NULL;
	}

	if ((current->right->type == SEP_AND)||(current->right->type == SEP_OR))
	{
		CMD* origional_right = current->right; //save right child

		current->right = current->right->left; //current's right child is current's right child's left child

		origional_right->left = current; //origional right child's left child is now current
	}

	else
	{
		return current; //return the current node cuz this is a base case
	}
	

	return rotate_command(origional_right); //recursive call
}

int handle_redirects(CMD* cmdList){
	char fname[] = "/tmp/fileXXXXXX";

	if (cmdList->toType == REDIR_OUT)
	{
		int output_file =  open(cmdList->toFile, O_CREAT | O_WRONLY | O_TRUNC , 0666);
		if (output_file < 0)
		{	
			perror("open failed ");
			setenv("?", "1", 1);
			return errno;
		}

		//handle the output file
		dup2(output_file, STDOUT_FILENO);
		close(output_file);
	}

	else if (cmdList->toType == REDIR_APP)
	{
		int output_file =  open(cmdList->toFile, O_CREAT | O_WRONLY | O_APPEND , 0666);
		if (output_file < 0)
		{
			perror("open failed ");
			setenv("?", "1", 1);
			return errno;
		}

		//handle the output file
		dup2(output_file, STDOUT_FILENO);
		close(output_file);	
	}

	//now we set up the input redirects.
	int input_file;
	if (cmdList->fromType == REDIR_HERE)
	{
		//make a temporary file to hold all the here doc stuff
		input_file = mkstemp(fname);

		if (input_file	== -1)
		{
			//making the input file failed
			char val[2];
			sprintf(val, "%d", errno);
			setenv("?", val, 1);
		}

		int n = 0;
		while (cmdList->fromFile[n++] != '\0'){}
			n--;
		//write all the stuff into the tempfile
		ssize_t bytes = write(input_file, cmdList->fromFile, sizeof(char)*n);
		lseek(input_file, 0, SEEK_SET);
		assert(bytes == sizeof(char)*n);
	}

	else if (cmdList->fromType == REDIR_IN)
	{
		input_file = open(cmdList->fromFile, O_CREAT | O_RDONLY , 0666);
		if (input_file < 0)
		{
			perror("open failed ");
			setenv("?", "1", 1);
			return errno;
		}
	}				

	if (cmdList->fromType == REDIR_IN || cmdList->fromType == REDIR_HERE)
	{
		//dup2
		dup2(input_file, STDIN_FILENO);
		close(input_file);
	}

	if (cmdList->fromType == REDIR_HERE)
	{
		unlink(fname);
	}

	return 1;
}

// Execute command list CMDLIST and return status of last command executed
int process_helper (CMD *cmdList){
	//let's implement some fucking local variables yo
	for (int i = 0; i < cmdList->nLocal; ++i)
	{
		setenv(cmdList->locVar[i], cmdList->locVal[i], 1);		
	}


	if (cmdList->type == SIMPLE)
	{
		//simple command. Now we need to see if it is one of the weird commands

		//cd command
		if (strcmp (cmdList->argv[0], "cd") == 0)
		{ //cd dirName - Change current working directory to DIRNAME, cd  - Equivalent to "cd $HOME" where HOME is an environment variable
			if (cmdList->argc > 2)
			{
				perror("too many args ");
				setenv("?", "1", 1);
				return errno;
			}

			else if (cmdList->argc == 1)
			{
				if (getenv("HOME") == NULL)
				{
					perror("home is NULL ");
					setenv("?", "1", 1);
					return errno;
				}

				chdir(getenv("HOME"));
			}

			else 
			{
				int error = chdir(cmdList->argv[1]);
				if (error < 0)
				{
					perror("chdir failed ");
					setenv("?", "1", 1);
					return errno;
				}
			}
		}

		//dirs command
		if (strcmp (cmdList->argv[0], "dirs") == 0)
		{//Print to stdout the working directory as defined by getcwd()
			if (cmdList->argc != 1)
			{
				perror("too man/few args ");
				setenv("?", "1", 1);
				return errno;
			}

			int rc = fork();
			int status;
			if (rc < 0) 
			{
				// fork failed
				perror("fork failure ");
				setenv("?", "1", 1);
				return errno;
			}

			if (rc == 0)
			{
				handle_redirects(cmdList);
				char* buffer = malloc(sizeof(char)*1024);
				char* return_pt = NULL;
				return_pt = getcwd(buffer, 1024);

				if (return_pt == NULL)
				{
					perror("getcwd has failed");
					char check[2];
					sprintf(check, "%d", STATUS(status));
					setenv("?", check, 1);
					exit(STATUS(status));
					return errno;
				}

				int length = 0;
				for (int i = 0; i < 1024; ++i)
				{
					if (buffer[i]== '\0')
					{
						buffer[i] = '\n';
						length = i+1;
						break;					
					}
				}

				write(STDOUT_FILENO, buffer, sizeof(char)*length);
				free(buffer);
				setenv("?", "0", 1);
				exit(0);
			}

			else
			{
				waitpid(rc, &status, 0);

				if (status < 0)
				{
					char check[2];
					sprintf(check, "%d", STATUS(status));
					setenv("?", check, 1);
					return -1;
				}
				return 0;
			}
		}

		//wait command
		if (strcmp (cmdList->argv[0], "wait") == 0)
		{//wait - Wait until all children of the shell process_helper have died. The status is 0. Note: The bash wait command takes command-line arguments that specify which children to wait for (vs. all of them).

			if (cmdList->argc != 1)
			{
				perror("incorrect args ");
				setenv("?", "1", 1);
				return -1;
			}

			int loop_pid;
			int loop_status;

			while((loop_pid = waitpid(-1, &loop_status, WNOHANG)) > 0)
			{
				fprintf(stderr, "Completed: %d (%d)\n", loop_pid, loop_status);
			}

			return 0;
		}

		else 
		{
			//this is a simple command, but there may be redirections and heredocuments. We handle those here
			//there are a few cases. <, << ; >, >> and a combination of the two sets. we will do this in the child proces

			//fork. Have child process_helper command. Parent waits on child and returns based on status. 
			int rc = fork();
			int status;
			if (rc < 0) 
			{
				// fork failed
				perror("fork failure ");
				setenv("?", "1", 1);
				return errno;
			}


			if (rc == 0)
			{
				//child process_helper. process_helper command
				//first we check the different out options and process_helper accordingly
				handle_redirects(cmdList);

				int status = execvp(cmdList->argv[0], cmdList->argv);
				if (status < 0)
				{
					perror("execvp failed");
					char check[2];
					sprintf(check, "%d", STATUS(status));
					setenv("?", check, 1);
					exit(STATUS(errno));	
					return errno;		
				}

				char check[2];
				sprintf(check, "%d", STATUS(status));
				setenv("?", check, 1);
				exit(STATUS(status));
			}

			else
			{
				//this is the parent process_helper. We must wait on the child process_helper. 
				waitpid(rc, &status, 0);

				char check[2];
				sprintf(check, "%d", STATUS(status));
				setenv("?", check, 1);
				return status;
			}

		}

	}

	///////////////////////////////////////////////////////////////////////////////////////////
	//implementing pipe which is not a simple command
	else if (cmdList->type == PIPE)
	{
		//first we make the pipe. pipeline[1] will be the out of left child, pipeline[0] will be in of right child
		int pipeline[2];
		int pipe_stat = pipe(pipeline);

		if (pipe_stat<0)
		{
			perror("pipe failure ");
			setenv("?", "1", 1);
			return errno;
		}

		//we need to fork twice. This if for left child
		int leftc = fork();
		int statusleft;
		if (leftc < 0) 
		{
			//fork failed
			perror("fork failure ");
			setenv("?", "1", 1);
			return errno;
		}

		//body of left child
		if (leftc == 0)
		{	
			//handle piping
			dup2(pipeline[1], STDOUT_FILENO);
			close(pipeline[1]);
			close(pipeline[0]);

			//recursively call process_helper on the left child of the command struct
			statusleft = process_helper(cmdList->left);
			char check[2];
			sprintf(check, "%d", STATUS(statusleft));
			setenv("?", check, 1);
			exit(STATUS(statusleft));
		}

		//second fork. this time for right child
		//we need to fork twice. This if for right child
		int rightc = fork();
		int statusright;
		if (rightc < 0) 
		{
			// fork failed
			perror("fork failure ");
			setenv("?", "1", 1);
			return errno;
		}

		//body of right child
		if (rightc == 0)
		{	
			//handle piping
			dup2(pipeline[0], STDIN_FILENO);
			close(pipeline[0]);
			close(pipeline[1]);

			//recursively call process_helper on the right child of the command struct
			statusright = process_helper(cmdList->right);
			char check[2];
			sprintf(check, "%d", STATUS(statusright));
			setenv("?", check, 1);
			exit(STATUS(statusright));
		}

		else
		{ //this is the parent function. Wait for both children and then return. 
			close(pipeline[0]);
			close(pipeline[1]);
			waitpid(leftc, &statusleft, 0);
			waitpid(rightc, &statusright, 0);

			//and the two return conditions together and return that. only way pipe is sucessful is if both children are sucessful.

			if (statusleft == 0)
			{
				char check[2];
				sprintf(check, "%d", STATUS(statusright));
				setenv("?", check, 1);
			}

			else
			{
				char check[2];
				sprintf(check, "%d", STATUS(statusleft));
				setenv("?", check, 1);
			}

			int status = statusleft && statusright;
			return status;
		}
	}

	//now we handle seperators. SEP_AND SEP_OR SEP_END///////////////////////////////////

	//sep_and
	else if (cmdList->type == SEP_AND) 
	{//call tree rotation stuff
		cmdList = rotate_command(cmdList);
		
		//process_helper on left. If false, don't run right
		int leftout = process_helper(cmdList->left);
		int rightout;

		if (leftout != 0)
		{
			char check[2];
			sprintf(check, "%d", STATUS(leftout));
			setenv("?", check, 1);
			return STATUS(leftout);
		}

		else
		{
			rightout = process_helper(cmdList->right);
		}

		char check[2];
		sprintf(check, "%d", STATUS(rightout));
		setenv("?", check, 1);
		return STATUS(rightout);
	}

	//sep_or
	else if (cmdList->type == SEP_OR) 
	{//call tree rotation stuff
		cmdList = rotate_command(cmdList);
		int rightout;
		
		//process_helper stuff on left. if true, don't run right
		int leftout = process_helper(cmdList->left);

		if (leftout == 0)
		{
			char check[2];
			sprintf(check, "%d", STATUS(leftout));
			setenv("?", check, 1);
			return STATUS(leftout);
		}

		else
		{
			rightout = process_helper(cmdList->right);
		}

		char check[2];
		sprintf(check, "%d", STATUS(rightout));
		setenv("?", check, 1);
		return STATUS(rightout);
	}

	//sep_end
	else if (cmdList->type == SEP_END)
	{
		int status;
		process_helper(cmdList->left);
		status = process_helper(cmdList->right);


		char check[2];
		sprintf(check, "%d", STATUS(status));
		setenv("?", check, 1);
		return STATUS(status);
	}
	
	//subcommands 
	else if (cmdList->type == SUBCMD)
	{//see if left child exists. if so, we fork. In child, process_helper redirections. call process_helper on that left child and exit. in parent, wait on child and return the status from child. 

		if (cmdList->left != NULL)
		 {
		 	int rc = fork();
			int status;
			if (rc < 0) 
			{
				// fork failed
				perror("fork failure ");
				setenv("?", "1", 1);
				return errno;
			}

			//body of right child
			if (rc == 0)
			{
				//handel redirections
				handle_redirects(cmdList);

				status = process_helper(cmdList->left);

				char check[2];
				sprintf(check, "%d", STATUS(status));
				setenv("?", check, 1);
				exit(STATUS(status));
			}

			//parent. wait on child
			else
			{
				waitpid(rc, &status, 0);
				char check[2];
				sprintf(check, "%d", STATUS(status));
				setenv("?", check, 1);
				return status;
			}
		 } 
	}

	//background process_helperes
	else if (cmdList->type == SEP_BG)
	{
		if ((cmdList->right != NULL) && (cmdList->left != NULL))
		{
			int rc = fork();
			int statusright;
			int statusleft;
			if (rc < 0) 
			{
				// fork failed
				perror("fork failure ");
				setenv("?", "1", 1);
				return errno;
			}

			//body of right child
			if (rc == 0)
			{
				//handel redirections
				handle_redirects(cmdList);

				statusleft = process_helper(cmdList->left);

				char check[2];
				sprintf(check, "%d", STATUS(statusleft));
				setenv("?", check, 1);
				exit(STATUS(statusleft));
			}

			//parent. wait on child
			else
			{
				fprintf(stderr, "Backgrounded: %d\n", rc);

				handle_redirects(cmdList);
				statusright = process_helper(cmdList->right);

				char check[2];
				sprintf(check, "%d", STATUS(statusright));
				setenv("?", check, 1);

				return STATUS(statusright);
			}
		}
	}

	return 0;
}

//we got this thing for reaping
int process (CMD *cmdList){
	//Come on baby, don't fear the reaper...
	int loop_pid;
	int loop_status;

	while((loop_pid = waitpid(-1, &loop_status, WNOHANG)) > 0)
	{
		fprintf(stderr, "Completed: %d (%d)\n", loop_pid, loop_status);
	}

	return process_helper(cmdList);
}

