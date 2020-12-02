DIM a AS INTEGER
DIM b AS INTEGER

unit ("test")
test ("expectEquals")
expectEqualsStr "1", "1", "1 ?= 1"

a = RND
b = a
expectEqualsInt a, b, "random variable equals itself"
endTest

test ("expectNotEquals")
expectNotEqualsInt 1, 0, "1 ?= 0"

RANDOMIZE TIMER
expectNotEqualsInt INT(RND * 100), INT(RND * 999), "RND != RND"

endTest
endUnit

'$include: './unit.bas'
