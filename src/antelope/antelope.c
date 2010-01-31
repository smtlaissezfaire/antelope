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

void add_node(node_set set, node * n) {
  if (set->node) {
    node_set new_element = malloc(sizeof(node_set));
    set->next = new_element;
    add_node(new_element, n);
  } else {
    set->node = n;
  }
}

node *find_node(node_set set, int id) {
  node_set current_set = set;

  do {
    if (current_set->node) {
      if (current_set->node->identifier == id) {
        return current_set->node;
      }
    }
  } while (current_set = current_set->next);

  return 0;
}