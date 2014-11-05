
// This is the test file to test various compilers.You can add expressions here
// at check the output after doing make

//By default it has KMP algorithm implemented and by running this function shows
// the 4-address quads for KMP algorithm


//I've implemented almost all the things given except "function declarations"



int prints(char *x);
int printi(int p);
int readi(int *eP);
int printi2(int a,int b);
int printc(char a);
int reads(char*a);
int printf(char*s,int a)
{
	return prints(s)+printi(a);
}

int strlen(char* s)
{
	int i=0;
	while(s[i]!='\0')i++;
	return i;
}


void print_grid(char (*board)[4]);
int didwin(char (*board)[4]);





  //Purpose: Two players battle in the classic game tic tac toe until one is proclaimed victor!




int main()
{
  int i=0,j=0,player=0,lead=0,nrows=0,ncols=0,winner=0;
  int again='q';
  char four_X_four[4][4];
  while(winner == '\0') {
  for(i = 0; i < 4; i++) {
    for(j = 0; j<4; j++) {
  four_X_four[i][j] = '\0';
    }
  }
  for( i = 0; i<16 && winner==0; i++)
    { 
    print_grid(four_X_four);
  player = i%2 + 1;
  if(player==1){
    printf("\n Player ", player); 
    prints (" : ");
      printc('X');prints(" ");
  }
  else if(player==2) {
    printf("\n Player ", player); 
    prints (" : ");
      printc('0');prints(" ");
  }
  readi( &lead);
  lead--;
  ncols = lead%4;
  lead = lead - ncols;
  nrows = lead/4;  
  if(lead<0 || lead>16 || four_X_four[nrows][ncols]=='X' || four_X_four[nrows][ncols]=='O') {
    prints("Space is already taken, please try again"); 
    i--;
  }
  else {
    four_X_four[nrows][ncols] = (player == 1) ? 'X' : 'O';
  }
  winner = didwin(four_X_four);
    }
  if(winner != '\0') {
    prints("Winner was ");printc(winner); prints(" Good job.\n");
  }
  else {
    prints("No winner this round. Try again.");
  }
  }
  return 0;
}
void print_grid(char (*board)[4]) {
  int i,j;
  prints("\n\n");
  for(i = 0; i < 4; i++) {
  for(j = 0; j < 4; j++) {
    if(board[i][j] == '\0') {
  printf(" ", 4*(i)+(j+1));prints(" ");
    }
    else {
      printc(' ');
  printc(board[i][j]);printc(' ');
    }
    if(j!=4) { prints("|"); }
  }
  if(i != 4) {
    prints("\n-------------------\n");
  }
  }
}

int didwin(char (*board)[4]) {
  int i,j;
  char current;
  char winner = '\0';

  //Iter over rows to check for winner
  for(i = 0; i<4; i++) {
  current = board[i][0];
  for(j = 0; j < 4; j++) {
    if(board[i][j] != current) {
  current = '\0';
    }
  }
  if(current != '\0') {
    winner = current;
  }
  }

  //Iter over columns
  for(i = 0; i<4; i++) {
  current = board[0][i];
  for(j = 0; j < 4; j++) {
    if(board[j][i] != current) {
  current = '\0';
    }
  }
  if(current != '\0') {
    winner = current;
  }
  }

  //Iter over diagonals
  current = board[0][0];
  for(i = 0; i < 4; i++) {
  if(board[i][i] != current) {
    current = '\0';
  }
  }
  if(current != '\0') {
  winner = current;
  }
  
  current = board[0][3];
  for(i = 0; i <4; i++) {
  if(board[i][4-i-1] != current) {
    current = '\0';
  }
  }
  if(current != '\0') {
  winner = current;
  }
  return winner;
}


