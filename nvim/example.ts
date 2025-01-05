// structural typed
// both are the same
type Person = { name: string }
type Human = { name: string }

function greet(person: Person) {
    console.log(`Hello, ${person.name}`);
}

const h: Human = { name: "Daniel" };
greet(h); // types are the same

// structural SUBtyping as well
// even though types are different, they are compatible
// if they share the same subtype
type Customer = { name: string, age: number }
const c: Customer = { name: "rick", age: 666 };
greet(c);
// types are different, but they are compatible because
// person is a subtype of Customer

// this also applies to classes

// type literals are awesome
type Fruit = "apple" | "banana" | "orange";
// if you use if (food.kind === "junk") the compiler will narrow down types for you
type Food = { kind: "junk";  taste: "good" | "bad" } | { kind: "fruit"; taste: "amazing" | "mid" };

// use namespace to group related types if you want to
namespace Bla {
  export function myBlaFn() {}
}

// always use const, unless you have to mutate
const x = 5;
const y = 6;
let a = 5;
a = 9;
// think of `const` as `let` in rust
// think of `let` as `let mut` in rust
// never EVER use `var`
