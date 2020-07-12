/**
 * Determines if the given tree contains a point with the same coordinates
 * as the given point.
 *
 * @param t a pointer to a valid k-d tree, non-NULL
 * @param p a pointer to a valid location, non-NULL
 * @return true if and only of the tree contains the location
 */
bool kdtree_contains(const kdtree *t, const location *p){
	printf("kdtree_contains has been called\n");

	//check to see if t and p are pointing to null
	if (t == NULL || p == NULL)
	{
		return false;
	}


	//check to see if the actual tree pointed to by t is empty
	if (t->root == NULL)
	{
		return false;
	}


	kdtree_node *current_node = t->root;
	//while the current node is not a leaf we check to see the value is equal
	while (current_node != NULL)
	{
		if (current_node->coordinates.x == p->x && current_node->coordinates.y == p->y)
		{
			return true;
		}

		else
		{
			//check if we are cutting on x dimension
			if (current_node->xaxis == true)
			{
				if (p->x < current_node->coordinates.x)	//see if we need to go down left subtree
				{
					current_node = current_node->leftchild
				}

				else //seems like we need to go down right subtree
				{
					current_node = current_node->rightchild
				}
			}

			//check if we are cutting on y dimension
			if (current_node->xaxis == false)
			{
				if (p->y < current_node->coordinates.y)	//see if we need to go down left subtree
				{
					current_node = current_node->leftchild
				}

				else //seems like we go down right subtree
				{
					current_node = current_node->rightchild
				}
			}
		}
	} 

	return false; //we have run outof nodes and have fallen off the tree
}


