%option noyywrap
%{

#include<stdio.h>
#include<string.h>
#include<shlwapi.h>

char pets[500], sports[500], food[500], fruits[500], vegetables[500], stationery[500];
char verbs[500];

char pets_db[][500] = {"dog", "cat", "pitbull", "terrier", "dalmatian", "tabby", "kitten", "puppy"};

char sports_db[][500] = {"cricket", "hockey", "tennis", "lacrosse", "rugby", "football", "badminton"};

char verbs_db[][500] = {"play","do","jump","eat","like","love","talk","go","read",
			"plays", "does", "jumps", "eats","likes","loves","talks","goes","reads",
			"played","did","jumped","ate","liked","loved","talked","gone"
			"playing","doing","jumping","eating","liking","loving","talking","going","reading"};

char fruits_db[][500] = {"mango","apple","kiwifruit","jackfruit","banana","watermelon","lychee","cherry","papaya","grapes","pear"};

char vegetables_db[][500] = {"cucumber","tomato","potato","pumpkin","lettuce","beetroot","carrot","yam","cabbage"};

char stationery_db[][500] = {"book","pencil","pen","ink","whitener","scale","rubber","eraser",
			     "books","pencils","pens","inks","whiteners","scales","rubbers","erasers"};

char users[][500] = {};

char u_sports[20][500] = {};
char u_pets[20][500] = {};
char u_verbs[20][500] = {};
char u_fruits[20][500] = {};
char u_vegetables[20][500] = {};
char u_stationery[20][500] = {};

char sports_samples[][500] = {"Kookaburra Cricket Bat", "Cricket Ball", "Cricket Stumps", "Tennis Ball", "Tennis Racquet",
			       "Badminton Racquet", "Badminton Shuttle", "Football", "Lacrosse Racquet", "Hockey Puck",
			       "Hockey Stick"};

char fruits_samples[][500] = {"Watermelon Ice Cream", "Mango Milkshake", "Well's Apple Juice", "Cherry Cake"};

char vegetables_samples[][500] = {"Lettuce Salad", "Cabbage Curry", "Fried Yams"};

char stationery_samples[][500] = {"Naveen Books", "Sidharth's Pens"};

char pets_samples[][500] = {"Orange Tabby", "Egyptian Cat", "Pedigree Dalmatian"};

int i, j, k, l, flag, user_count;
int temp_counter;
char temp_str[500] = "";

void CompareAndAdd(char *str, char strarr[][500], int size)
{
	for(i = 0; i<size; i++)
	{
		if(strcasecmp(yytext, strarr[i]) == 0)
		{
			strcat(str, yytext);
			str[strlen(str)] = '$';
			flag = 1;
		}
	}
}

void AllocateToUser(char str[500], char strarr[20][500])
{
	i = 0;
	j = 0;
	temp_counter = 1;

	printf("For %s: ",users[temp_counter]);

	while(str[i] != '\0')
	{
		if(str[i] == '-')
		{
			temp_counter++;

			if(temp_counter <= user_count)
			{
				printf("\nFor %s: ",users[temp_counter]);
				j = 0;
			}

			i++;
		}
		else if(str[i] == '$')
		{
			printf(" ");

			strarr[temp_counter-1][j] = '|';

			i++;
			j++;
		}
		else
		{
			printf("%c",str[i]);

			strarr[temp_counter-1][j] = str[i];

			i++;
			j++;
		}
	}

	printf("\n");
}

void Recommend(char strarr[20][500], char sample_db[][500], int size)
{
	i = 0;
	j = 0;
	k = 0;
	l = 0;

	while(i< user_count)
	{
		printf("\nFor %s: ",users[i+1]);

		j = 0;

		while(strarr[i][j] != '\0')
		{
			if(strarr[i][j] == '|')
			{
				temp_str[k] = '\0';

				for(l=0; l<size; l++)
				{
					if(StrStrIA(sample_db[l],temp_str))
					{
						printf("%s | ",sample_db[l]);
					}
				}

				k = 0;

				strcpy(temp_str,"");
			}
			else
			{
				temp_str[k] = strarr[i][j];
				k++;
			}

			j++;
		}

		i++;
	}
}

void RecommendationPhase()
{
	printf("\nRecommendations: \n\n");

	printf("Sports Recommendations: ");
	Recommend(u_sports, sports_samples, sizeof(sports_samples)/sizeof(sports_samples[0]));

	printf("\n\nFruits Recommendations: ");
	Recommend(u_fruits, fruits_samples, sizeof(fruits_samples)/sizeof(fruits_samples[0]));

	printf("\n\nVegetables Recommendations: ");
	Recommend(u_vegetables, vegetables_samples, sizeof(vegetables_samples)/sizeof(vegetables_samples[0]));

	printf("\n\nStationery Recommendations: ");
	Recommend(u_stationery, stationery_samples, sizeof(vegetables_samples)/sizeof(vegetables_samples[0]));

	printf("\n\nPet Recommendations: ");
	Recommend(u_pets, pets_samples, sizeof(pets_samples)/sizeof(pets_samples[0]));

}

void PrintIdentificationPhase()
{
	printf("\nPets Registered: %s\n",pets);
	printf("Sports Registered: %s\n",sports);
	printf("Fruits Registered: %s\n",fruits);
	printf("Vegetables Registered: %s\n",vegetables);
	printf("Stationeries Registered: %s\n",stationery);
	printf("Actions Registered: %s\n",verbs);
}

void AllocationPhase()
{
	printf("\nPets allocated to Users: \n");
	AllocateToUser(pets, u_pets);

	printf("\nSports allocated to Users: \n");
	AllocateToUser(sports, u_sports);

	printf("\nFruits allocated to Users: \n");
	AllocateToUser(fruits, u_fruits);

	printf("\nVegetables allocated to Users: \n");
	AllocateToUser(vegetables, u_vegetables);

	printf("\nStationery allocated to Users: \n");
	AllocateToUser(stationery, u_stationery);

	printf("\nActions allocated to Users: \n");
	AllocateToUser(verbs, u_verbs);
}

%}

%%

"this"|"is"|"a"|"an"|"the"|"it"|"that"|"and"|"or"|"not"|"he"|"she"|"with"|"also"|"for"|"while"|"I"|"He"|"over"|"to" ;
[:.;,''""] ;

[a-zA-Z]+ {
		flag = 0;		

		CompareAndAdd(pets, pets_db, sizeof(pets_db)/sizeof(pets_db[0]));
		CompareAndAdd(sports, sports_db, sizeof(sports_db)/sizeof(sports_db[0]));
		CompareAndAdd(verbs, verbs_db, sizeof(verbs_db)/sizeof(verbs_db[0]));
		CompareAndAdd(fruits, fruits_db, sizeof(fruits_db)/sizeof(fruits_db[0]));
		CompareAndAdd(vegetables, vegetables_db, sizeof(vegetables_db)/sizeof(vegetables_db[0]));
		CompareAndAdd(stationery, stationery_db, sizeof(stationery_db)/sizeof(stationery_db[0]));

		if(flag == 0)
		{
			strcpy(users[user_count], yytext);
		}
		
	   }

[\n] {
	strcat(pets,"-");
	strcat(sports,"-");
	strcat(verbs,"-");
	strcat(fruits,"-");
	strcat(vegetables,"-");
	strcat(stationery,"-");

	user_count++;
     }

[\t ] ;

. ;

-1 return 0;
%%

int main()
{
FILE *ptr=fopen("input.txt","r");
yyin=ptr;

user_count = 1;

yylex();

printf("\nNumber of Users: %d\n",user_count);

//PrintIdentificationPhase();

AllocationPhase();

RecommendationPhase();

return 0;

}
