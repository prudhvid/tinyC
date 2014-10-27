int gcd ( int a, int b )
{
  int c;
  while ( a != 0 ) {
     c = a; 
     a = b%a;
       b = c;
  }
  return b;
}

/* Recursive Standard C Function: Greatest Common Divisor */
int gcdr ( int a, int b )
{
  if ( a==0 ) return b;
  return gcdr ( b%a, a );
}

int gcdv()
{
  return 0;
}

int main()
{
  int a,b,c;
  a = 299792458;
  b = 6447287;
  c = 256964964;

  gcd(a,b);
  gcdr(gcd(a, a+b), gcdr(a*b,b*gcdv()));
  return 0;
}