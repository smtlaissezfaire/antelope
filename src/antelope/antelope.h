typedef unsigned int uint;

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
  uint       identifier;
  enum types type;
  uint *     references;
  char *     text;
  int        (*parse)(int, char *);
};

typedef struct node node;

node mk_literal   (uint, char *);
node mk_rule      (uint, unsigned int *);
int parse_literal (int, char *);
int parse_rule    (int, char *);