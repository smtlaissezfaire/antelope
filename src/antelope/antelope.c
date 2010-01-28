#include "antelope.h"

node mk_node(uint identifier, enum types type, int (*parse_func)(node *, int, string)) {
  node n;
  n.identifier = identifier;
  n.type       = type;
  n.parse      = parse_func;
  return n;
}

node mk_literal(uint identifier, string str) {
  node n = mk_node(identifier, LITERAL, parse_literal);
  n.text = str;
  return n;
}

node mk_rule(uint identifier, uint *references) {
  node n = mk_node(identifier, RULE, parse_rule);
  n.references = references;
  return n;
}

node mk_alternation(uint identifier, uint *references) {
  node n = mk_node(identifier, ALTERNATION, parse_rule);
  return n;
}

int parse_literal(node *self, int start, string str) {
  int match_length = strlen(self->text);

  if (memcmp(str + start, self->text, match_length) == 0) {
    return start + match_length;
  } else {
    return PARSE_FAILURE;
  }
}

int parse_rule(node * self, int start, string str) {}
int parse_alternation(node *self, int start, string str) {}
