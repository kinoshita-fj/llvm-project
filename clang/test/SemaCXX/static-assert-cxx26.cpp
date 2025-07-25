// RUN: %clang_cc1 -std=c++2c -triple=x86_64-linux -fsyntax-only %s -verify
// RUN: %clang_cc1 -std=c++2c -triple=x86_64-linux -fsyntax-only %s -verify -fexperimental-new-constant-interpreter

static_assert(true, "");
static_assert(true, 0); // expected-error {{the message in a static assertion must be a string literal or an object with 'data()' and 'size()' member functions}}
struct Empty{};
static_assert(true, Empty{}); // expected-error {{the message object in this static assertion is missing 'data()' and 'size()' member functions}}
struct NoData {
    unsigned long size() const;
};
struct NoSize {
    const char* data() const;
};
static_assert(true, NoData{}); // expected-error {{the message object in this static assertion is missing a 'data()' member function}}
static_assert(true, NoSize{}); // expected-error {{the message object in this static assertion is missing a 'size()' member function}}

struct InvalidSize {
    const char* size() const;
    const char* data() const;
};
static_assert(true, InvalidSize{}); // expected-error {{the message in a static assertion must have a 'size()' member function returning an object convertible to 'std::size_t'}} \
                                    // expected-error {{value of type 'const char *' is not implicitly convertible to '__size_t' (aka 'unsigned long')}}
struct InvalidData {
    unsigned long size() const;
    unsigned long data() const;
};
static_assert(true, InvalidData{}); // expected-error {{the message in a static assertion must have a 'data()' member function returning an object convertible to 'const char *'}} \
                                    // expected-error {{value of type 'unsigned long' is not implicitly convertible to 'const char *'}}

struct NonConstexprSize {
    unsigned long size() const; // expected-note 2{{declared here}}
    constexpr const char* data() const;
};

static_assert(true, NonConstexprSize{}); // expected-error {{the message in this static assertion is not a constant expression}} \
                                         // expected-note  {{non-constexpr function 'size' cannot be used in a constant expression}}

static_assert(false, NonConstexprSize{}); // expected-error {{the message in a static assertion must be produced by a constant expression}} \
                                          // expected-error {{static assertion failed}} \
                                          // expected-note  {{non-constexpr function 'size' cannot be used in a constant expression}}

struct NonConstexprData {
    constexpr unsigned long size() const {
        return 32;
    }
    const char* data() const;  // expected-note 2{{declared here}}
};

static_assert(true, NonConstexprData{});  // expected-error {{the message in this static assertion is not a constant expression}} \
                                          // expected-note  {{non-constexpr function 'data' cannot be used in a constant expression}}

static_assert(false, NonConstexprData{}); // expected-error {{the message in a static assertion must be produced by a constant expression}} \
                                          // expected-error {{static assertion failed}} \
                                          // expected-note  {{non-constexpr function 'data' cannot be used in a constant expression}}

struct string_view {
    int S;
    const char* D;
    constexpr string_view(const char* Str) : S(__builtin_strlen(Str)), D(Str) {}
    constexpr string_view(int Size, const char* Str) : S(Size), D(Str) {}
    constexpr int size() const {
        return S;
    }
    constexpr const char* data() const {
        return D;
    }
};

constexpr string_view operator+(auto, string_view S) {
    return S;
}

constexpr const char g_[] = "long string";

template <typename T, int S>
struct array {
    constexpr unsigned long size() const {
        return S;
    }
    constexpr const char* data() const {
        return d_;
    }
    const char d_[S];
};

static_assert(false, string_view("test")); // expected-error {{static assertion failed: test}}
static_assert(false, "Literal" + string_view("test")); // expected-error {{static assertion failed: test}}
static_assert(false, L"Wide Literal" + string_view("test")); // expected-error {{static assertion failed: test}}
static_assert(false, "Wild" "Literal" "Concatenation" + string_view("test")); // expected-error {{static assertion failed: test}}
static_assert(false, "Wild" "Literal" L"Concatenation" + string_view("test")); // expected-error {{static assertion failed: test}}
static_assert(false, "Wild" u"Literal" L"Concatenation" + string_view("test")); // expected-error {{unsupported non-standard concatenation of string literals}}
static_assert(false, string_view("😀")); // expected-error {{static assertion failed: 😀}}
static_assert(false, string_view(0, nullptr)); // expected-error {{static assertion failed:}}
static_assert(false, string_view(1, "ABC")); // expected-error {{static assertion failed: A}}
static_assert(false, string_view(42, "ABC")); // expected-error {{static assertion failed: ABC}} \
                                              // expected-error {{the message in a static assertion must be produced by a constant expression}} \
                                              // expected-note {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
static_assert(false, array<char, 2>{'a', 'b'}); // expected-error {{static assertion failed: ab}}



struct ConvertibleToInt {
    constexpr operator int() {
        return 4;
    }
};
struct ConvertibleToCharPtr {
    constexpr operator const char*() {
        return "test";
    }
};
struct MessageFromConvertible {
    constexpr ConvertibleToInt size() const {
        return {};
    }
    constexpr ConvertibleToCharPtr data() const {
        return {};
    }
};

static_assert(true, MessageFromConvertible{});
static_assert(false, MessageFromConvertible{}); // expected-error{{static assertion failed: test}}



struct Leaks {
    constexpr unsigned long size() const {
        return 2;
    }
    constexpr const char* data() const {
        return new char[2]{'u', 'b'}; // expected-note {{allocation performed here was not deallocated}}
    }
};

static_assert(false, Leaks{}); //expected-error {{the message in a static assertion must be produced by a constant expression}} \
                              // expected-error {{static assertion failed: ub}}

struct RAII {
    const char* d = new char[2]{'o', 'k'};
    constexpr unsigned long size() const {
        return 2;
    }

    constexpr const char* data() const {
        return d;
    }

    constexpr ~RAII() {
        delete[] d;
    }
};
static_assert(false, RAII{}); // expected-error {{static assertion failed: ok}}

namespace MoreTemporary {

struct Data{
constexpr operator const char*() const {
    return d;
}
char d[6] = { "Hello" };
};

struct Size {
     constexpr operator int() const {
        return 5;
    }
};

struct Message {
    constexpr auto size() const {
        return Size{};
    }
    constexpr auto data() const {
        return Data{};
    }
};

static_assert(false, Message{}); // expected-error {{static assertion failed: Hello}}

}

struct MessageInvalidSize {
    constexpr unsigned long size(int) const; // expected-note {{'size' declared here}}
    constexpr const char* data() const;
};
struct MessageInvalidData {
    constexpr unsigned long size() const;
    constexpr const char* data(int) const; // expected-note {{'data' declared here}}
};

static_assert(false, MessageInvalidSize{});  // expected-error {{static assertion failed}} \
                                             // expected-error {{the message in a static assertion must have a 'size()' member function returning an object convertible to 'std::size_t'}} \
                                             // expected-error {{too few arguments to function call, expected 1, have 0}}
static_assert(false, MessageInvalidData{});  // expected-error {{static assertion failed}} \
                                             // expected-error {{the message in a static assertion must have a 'data()' member function returning an object convertible to 'const char *'}} \
                                             // expected-error {{too few arguments to function call, expected 1, have 0}}

struct NonConstMembers {
    constexpr int size() {
        return 1;
    }
    constexpr const char* data() {
        return "A";
    }
};

static_assert(false, NonConstMembers{}); // expected-error {{static assertion failed: A}}

struct DefaultArgs {
    constexpr int size(int i = 0) {
        return 2;
    }
    constexpr const char* data(int i =0, int j = 42) {
        return "OK";
    }
};

static_assert(false, DefaultArgs{}); // expected-error {{static assertion failed: OK}}

struct Variadic {
    constexpr int size(auto...) {
        return 2;
    }
    constexpr const char* data(auto...) {
        return "OK";
    }
};

static_assert(false, Variadic{}); // expected-error {{static assertion failed: OK}}

template <typename T>
struct DeleteAndRequires {
    constexpr int size() = delete; // expected-note {{'size' has been explicitly marked deleted here}}
    constexpr const char* data() requires false; // expected-note {{because 'false' evaluated to false}}
};
static_assert(false, DeleteAndRequires<void>{});
// expected-error@-1 {{static assertion failed}} \
// expected-error@-1 {{the message in a static assertion must have a 'size()' member function returning an object convertible to 'std::size_t'}}\
// expected-error@-1 {{invalid reference to function 'data': constraints not satisfied}} \
// expected-error@-1 {{attempt to use a deleted function}}

class Private {
    constexpr int size(int i = 0) { // expected-note {{implicitly declared private here}}
        return 2;
    }
    constexpr const char* data(int i =0, int j = 42) { // expected-note {{implicitly declared private here}}
        return "OK";
    }
};

static_assert(false, Private{}); // expected-error {{'data' is a private member of 'Private'}}\
                                 // expected-error {{'size' is a private member of 'Private'}}\
                                 // expected-error {{static assertion failed: OK}}

struct MessageOverload {
    constexpr int size() {
        return 1;
    }
    constexpr int size() const;

    constexpr const char* data() {
        return "A";
    }
    constexpr const char* data() const;
};

static_assert(false, MessageOverload{}); // expected-error {{static assertion failed: A}}

struct InvalidPtr {
    consteval auto size() {
        return 42;
    }
    consteval const char *data() {
    const char *ptr; // Garbage
    return ptr; // expected-note {{read of uninitialized object is not allowed in a constant expression}}
    }
};

static_assert(false, InvalidPtr{}); // expected-error{{the message in a static assertion must be produced by a constant expression}} \
                           //expected-error {{static assertion failed}} \
                           // expected-note {{in call to 'InvalidPtr{}.data()'}}

namespace DependentMessage {
template <typename Ty>
struct Good {
  static_assert(false, Ty{}); // expected-error {{static assertion failed: hello}}
};

template <typename Ty>
struct Bad {
  static_assert(false, Ty{}); // expected-error {{the message in a static assertion must be a string literal or an object with 'data()' and 'size()' member functions}} \
                              // expected-error {{static assertion failed}}
};

struct Frobble {
  constexpr int size() const { return 5; }
  constexpr const char *data() const { return "hello"; }
};

constexpr Frobble operator ""_myd (const char *, unsigned long) { return Frobble{}; }
static_assert (false, "foo"_myd); // expected-error {{static assertion failed: hello}}

Good<Frobble> a; // expected-note {{in instantiation}}
Bad<int> b; // expected-note {{in instantiation}}

}

namespace EscapeInDiagnostic {
static_assert('\u{9}' == (char)1, ""); // expected-error {{failed}} \
                                       // expected-note {{evaluates to ''\t' (0x09, 9) == '<U+0001>' (0x01, 1)'}}
static_assert((char8_t)-128 == (char8_t)-123, ""); // expected-error {{failed}} \
                                                   // expected-note {{evaluates to 'u8'<80>' (0x80, 128) == u8'<85>' (0x85, 133)'}}
static_assert((char16_t)0xFEFF == (char16_t)0xDB93, ""); // expected-error {{failed}} \
                                                         // expected-note {{evaluates to 'u'﻿' (0xFEFF, 65279) == u'\xDB93' (0xDB93, 56211)'}}
}

struct Static {
  static constexpr int size() { return 5; }
  static constexpr const char *data() { return "hello"; }
};
static_assert(false, Static{}); // expected-error {{static assertion failed: hello}}

struct Data {
    unsigned long size = 0;
    const char* data = "hello";
};
static_assert(false, Data{}); // expected-error {{called object type 'unsigned long' is not a function or function pointer}} \
                              // expected-error {{called object type 'const char *' is not a function or function pointer}} \
                              // expected-error {{the message in a static assertion must have a 'size()' member function returning an object convertible to 'std::size_t'}} \
                              // expected-error {{static assertion failed}}

struct Callable {
    struct {
        constexpr auto operator()() const {
            return 5;
        };
    } size;
    struct {
        constexpr auto operator()() const {
            return "hello";
        };
    } data;
};
static_assert(false, Callable{}); // expected-error {{static assertion failed: hello}}

namespace GH89407 {
struct A {
  constexpr __SIZE_TYPE__ size() const { return -1; }
  constexpr const char* data() const { return ""; }
};

struct B {
  constexpr long long size() const { return 18446744073709551615U; }
  constexpr const char* data() const { return ""; }
};

struct C {
  constexpr __int128 size() const { return -1; }
  constexpr const char* data() const { return ""; }
};

struct D {
  constexpr unsigned __int128 size() const { return -1; }
  constexpr const char* data() const { return ""; }
};

struct E {
  constexpr __SIZE_TYPE__ size() const { return 18446744073709551615U; }
  constexpr const char* data() const { return ""; }
};

static_assert(true, A{}); // expected-error {{the message in this static assertion is not a constant expression}}
                          // expected-note@-1 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
static_assert(true, B{}); // expected-error {{call to 'size()' evaluates to -1, which cannot be narrowed to type '__size_t' (aka 'unsigned long')}}
                          // expected-error@-1 {{the message in this static assertion is not a constant expression}}
                          // expected-note@-2 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
static_assert(true, C{}); // expected-error {{call to 'size()' evaluates to -1, which cannot be narrowed to type '__size_t' (aka 'unsigned long')}}
                          // expected-error@-1 {{the message in this static assertion is not a constant expression}}
                          // expected-note@-2 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
static_assert(true, D{}); // expected-error {{call to 'size()' evaluates to 340282366920938463463374607431768211455, which cannot be narrowed to type '__size_t' (aka 'unsigned long')}}
                          // expected-error@-1 {{the message in this static assertion is not a constant expression}}
                          // expected-note@-2 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
static_assert(true, E{}); // expected-error {{the message in this static assertion is not a constant expression}}
                          // expected-note@-1 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}

static_assert(
  false, // expected-error {{static assertion failed}}
  A{} // expected-error {{the message in a static assertion must be produced by a constant expression}}
      // expected-note@-1 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
);

static_assert(
  false, // expected-error {{static assertion failed}}
  B{} // expected-error {{call to 'size()' evaluates to -1, which cannot be narrowed to type '__size_t' (aka 'unsigned long')}}
      // expected-error@-1 {{the message in a static assertion must be produced by a constant expression}}
      // expected-note@-2 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
);

static_assert(
  false, // expected-error {{static assertion failed}}
  C{} // expected-error {{call to 'size()' evaluates to -1, which cannot be narrowed to type '__size_t' (aka 'unsigned long')}}
      // expected-error@-1 {{the message in a static assertion must be produced by a constant expression}}
      // expected-note@-2 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
);

static_assert(
  false, // expected-error {{static assertion failed}}
  D{} // expected-error {{call to 'size()' evaluates to 340282366920938463463374607431768211455, which cannot be narrowed to type '__size_t' (aka 'unsigned long')}}
      // expected-error@-1 {{the message in a static assertion must be produced by a constant expression}}
      // expected-note@-2 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
);

static_assert(
  false, // expected-error {{static assertion failed}}
  E{} // expected-error {{the message in a static assertion must be produced by a constant expression}}
      // expected-note@-1 {{read of dereferenced one-past-the-end pointer is not allowed in a constant expression}}
);
}
