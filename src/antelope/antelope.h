enum types {
  RULE = 1,
  LITERAL,
  ALTERNATION,
  GROUPED_EXPRESSION,
  OPTIONAL_EXPRESSION,
  OPTIONAL_REPETITION,
  REPETITION
};

struct node {
  unsigned int   identifier;
  enum types     type;
  unsigned int * references;
  char *         text;
  int            (*parse)(int, char *);
};

typedef struct node node;

node mk_literal(int, char *);
node mk_rule(int, unsigned int *);

int parse_literal(int, char *);
int parse_rule(int, char *);