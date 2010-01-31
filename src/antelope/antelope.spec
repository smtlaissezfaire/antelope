#include "cspec.h"
#include "antelope.h"
#include "limits.h"
#include "string.h"

static int nbefore_each;

describe "basic specs"
  before_each
    ++nbefore_each;
  end

  it "should be called before each spec"
    nbefore_each should equal 1
  end

  it "should be called before each spec"
    nbefore_each should equal 2
  end
end

struct node node_struct;

int generic_parse_function(node * self, int x, char * str) {
  (void)self;
  (void)(str);
  return x * x;
}

describe "node struct"
  it "should have type as an integer"
    node_struct.type = 1;
    node_struct.type should equal 1

    node_struct.type = 2;
    node_struct.type should equal 2
  end

  it "should have the identifier as an unsigned int"
    node_struct.identifier = UINT_MAX;
    node_struct.identifier should equal UINT_MAX;
  end

  it "should have an optional body of text"
    char *x = "foo";
    node_struct.text = x;
    node_struct.text should equal x
  end

  it "should have a list of references"
    unsigned int *references = malloc(sizeof(int) * 2);
    references[0] = 0;
    references[1] = 1;

    node_struct.references = references;
    node_struct.references should equal references;
  end

  it "should have the parse function"
    node_struct.parse = generic_parse_function;
    int x = (*node_struct.parse)(&node_struct, 4, "");
    x should equal 16
  end
end

describe "types"
  it "should have type 1 as a rule"
    enum types type = RULE;
    type should equal 1
  end

  it "should have a literal as type 2"
    enum types type = LITERAL;
    type should equal 2
  end

  it "should have an alternation as type 3"
    enum types type = ALTERNATION;
    type should equal 3
  end

  it "should have a grouped expression as type 4"
    enum types type = GROUPED_EXPRESSION;
    type should equal 4
  end

  it "should have an optional expression as type 5"
    enum types type = OPTIONAL_EXPRESSION;
    type should equal 5
  end

  it "should have an optional repetition as type 6"
    enum types type = OPTIONAL_REPETITION;
    type should equal 6
  end

  it "should have a repetition as type 7"
    enum types type = REPETITION;
    type should equal 7
  end
end

describe "mk_literal"
  it "should set the id"
    int str = mk_literal(10, "foo").identifier;
    str should equal 10
  end

  it "should use the correct id"
    int str = mk_literal(100, "foo").identifier;
    str should equal 100
  end

  it "should set the text"
    char *txt_given = "foo";
    char *text = mk_literal(100, txt_given).text;
    text should equal txt_given
  end

  it "should have type = 2"
    int type = mk_literal(100, "foo").type;
    type should equal LITERAL
  end

  it "should have the parse function as a pointer to literal_parse"
    node rule = mk_literal(100, "foo");
    rule.parse should equal parse_literal
  end
end

describe "parsing a literal"
  it "should return -1 if it doesn't match"
    node literal = mk_literal(0, "foo");
    int result = literal.parse(&literal, 0, "not_matching");
    result should equal -1
  end

  it "should return +1 when matching one char exactly"
    node literal = mk_literal(0, "a");
    int result = literal.parse(&literal, 0, "a");
    result should equal 1
  end

  it "should return +2 when matching two chars exactly"
    node literal = mk_literal(0, "ab");
    int result = literal.parse(&literal, 0, "ab");
    result should equal 2
  end

  it "should return a parse failure if it matches the first char, but not the second"
    node literal = mk_literal(0, "aa");
    int result = literal.parse(&literal, 0, "ab");
    result should equal -1
  end

  it "should match starting at the offset"
    node literal = mk_literal(0, "bar");
    int result = literal.parse(&literal, 3, "foobar");
    result should equal 6
  end

  it "should match in the middle & return the correct offset"
    node literal = mk_literal(0, "bar");
    int result = literal.parse(&literal, 3, "foobarbaz");
    result should equal 6
  end
end

unsigned int reference_list[2];

describe "mk_rule"
  it "should have type = 1"
    node rule = mk_rule(100, reference_list);
    rule.type should equal RULE
  end

  it "should have the identifier"
    node rule = mk_rule(100, reference_list);
    rule.identifier should equal 100
  end

  it "should use the correct id"
    node rule = mk_rule(200, reference_list);
    rule.identifier should equal 200
  end

  it "should have a list of references"
    node rule = mk_rule(100, reference_list);
    rule.references should equal reference_list
  end

  it "should use the parse_rule function"
    node rule = mk_rule(100, reference_list);
    rule.parse should equal parse_rule
  end
end

describe "mk_alternation"
  it "should have type alternation"
    node alternation = mk_alternation(0, reference_list);
    alternation.type should equal ALTERNATION;
  end
end

describe "adding nodes"
  it "should add the first node"
    node_set set = malloc(sizeof(node_set));
    node n1;
    node *value;

    add_node(set, &n1);
    value = set->node;

    value should equal &n1
  end

  it "should add the second node as the second value"
    node_set set = malloc(sizeof(node_set) * 2);
    node n1;
    node n2;
    node *value;

    add_node(set, &n1);
    add_node(set, &n2);
    value = set->next->node;

    value should equal &n2
  end
end

describe "node set"
  it "should return 0 if the set doesn't have a first node"
    node_set set = malloc(sizeof(node_set));

    find_node(set, 1) should equal 0
  end

  it "should return the node when it matches"
    node_set set = malloc(sizeof(node_set));
    node n1;

    n1.identifier = 1;
    add_node(set, &n1);

    find_node(set, 1) should equal &n1;
  end

  it "should return 0 if it the node has one element, but doesn't match"
    node_set set = malloc(sizeof(node_set));
    node n1;

    n1.identifier = 2;
    add_node(set, &n1);

    find_node(set, 1) should equal 0
  end

  it "should use the correct id"
    node_set set = malloc(sizeof(node_set));
    node n1;

    n1.identifier = 1;
    add_node(set, &n1);

    find_node(set, 2) should equal 0
  end

  it "should match the correct nodes"
    node_set set = malloc(sizeof(node_set));
    node n1;
    node n2;

    n1.identifier = 1;
    n2.identifier = 2;

    add_node(set, &n1);
    add_node(set, &n2);

    find_node(set, 1) should equal &n1;
    find_node(set, 2) should equal &n2;
  end
end