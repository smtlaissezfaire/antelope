typedef unsigned int uint;
typedef char *       string;

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
  string     text;
  int        (*parse)(int, string);
};

typedef struct node node;

node mk_literal   (uint, string);
node mk_rule      (uint, unsigned int *);
int parse_literal (int, string);
int parse_rule    (int, string);