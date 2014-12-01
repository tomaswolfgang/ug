#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void decode(char *source,char *last, char *dest)
{
for(; source != last; source++, dest++)
	{
   if(*source == '+' )
     *dest = ' ';
   else if(*source == '%') {
     int code;
     if(sscanf(source+1, "%2x", &code) != 1) code = '?';
     *dest = code;
     source +=2; }     
   else
     *dest = *source;
	}
 *dest = '\0';


}

int main()
{
char *lenstr;
char input[80], data[80], line[100], usern[50], pword[50];
long len;
char commasep[2] = ",";
int usrexist = 0, i=0, action = 0, p=0, u=0;
printf("%s%c%c\n",
"Content-Type:text/html;charset=iso-8859-1",13,10);
printf("<TITLE>Response</TITLE>\n");
lenstr = getenv("CONTENT_LENGTH");
if(lenstr == NULL || sscanf(lenstr,"%ld",&len)!=1 || len > 80)
  printf("<P>wrong FORM" );
else {
  fgets(input, len+1, stdin);
  decode(input, input+len, data);
  for(i; i<100; i++)
	{
	if(data[i]=='&')action++;
	if(action==1){
	usern[u] = data[i];
	u++;
	}
	if(action > 1) usern[u] = '\0';
	if(action==3){
	pword[p] = data[i];
	p++;
	}
	if(data[i]=='=') action++;
	if(data[i]=='\0') break;
	}
usern[u] = '\0';
pword[p] = '\0';
  FILE *fpoint;
  fpoint = fopen("./members.csv", "r");
  if(fpoint == NULL){
        printf("<p> No users registered. </p>");
        }
  else{
        while(fgets(line, 99, fpoint) !=NULL){
		char *memberu= strtok(line, commasep);
		char *memberp= strtok(NULL, commasep);
                if (strcmp(memberu,usern) ==0 && strcmp(memberp,pword) == 0){
				usrexist = 1;
				break;
                        }
                else continue;
        
}
fclose(fpoint);
  }
if (usrexist == 1){
printf("<center><h1> Welcome %s  </h1></center>\n",usern);
FILE *logged, *html;
logged = fopen("./loggedin.csv", "a");
fprintf(logged, "%s,", usern);
fclose(logged);
//SWITCH TO CATALOGUE
html = fopen("./index.html", "r");
while(fgets(line,99,html) != NULL){
if(strcmp(line,"<!--insert here-->\n")==0) {
//printf("<input type=\"hidden\" name=\"user\" value=\"%s\"\n", usern);
}
else printf("%s\n",line);
}
}
else
{
FILE *html;
html = fopen("./login.html", "r");
while(fgets(line,99,html) != NULL){
if(strcmp(line,"<!--insert here-->\n")==0){
printf("<h2> ***** Your user doesn't exist! *****</h2>");
printf("<a href=\"./registration.html\">Click here to REGISTER</a>");
}
else printf("%s\n",line);
}
}
}
return 0;
}
