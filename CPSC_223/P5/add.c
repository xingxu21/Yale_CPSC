
void insert(kdtree *t, const location *p){
	while ((t->coordinates.x != p->x) && (t->coordinates.y != p->y))
	{
		 
	}
}




bool kdtree_add(kdtree *t, const location *p){
	printf("kdtree_add has been called\n");

	//first we check if the pointers are actually pointing to null and tring to make me not pass shit fkn pointers being sneaky time to die
	if (t == NULL)
	{
		printf("kdtree_add was passed t -> NULL\n");
		return false;
	}

	else if (p == NULL)
	{
		printf("kdtree_add was passed p -> NULL which means the input is a hot pile of horse shit\n");
		return false;
	}

	//now we check if the point is already in the tree. If so we do nothing
	else if (kdtree_contains(t, p) == true)
	{
		printf("we found that our tree already contains this point\n");
		return false;
	}

	//the pointers are good and there are not duplicates so we call insert
	else 
	{
		insert(t, p);
	}
}
