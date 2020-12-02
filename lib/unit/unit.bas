TYPE UnitType
  name AS STRING * 64
  passes AS INTEGER
  fails AS INTEGER
END TYPE

TYPE TestType
  name AS STRING * 64
  expectationCount AS INTEGER
END TYPE


DIM SHARED currentTest AS TestType
DIM SHARED currentUnit AS UnitType

SUB addExpectation ()
  currentTest.expectationCount = currentTest.expectationCount + 1
END SUB

SUB printTestName (message$)
  PRINT RTRIM$(LTRIM$(currentUnit.name)) + " > " + RTRIM$(LTRIM$(currentTest.name)) + " > " + message$;
END SUB

SUB pass (message$)
  printTestName message$
  PRINT ": pass"
  currentUnit.passes = currentUnit.passes + 1
END SUB

SUB fail (message$)
  printTestName message$
  PRINT ": fail"
  currentUnit.fails = currentUnit.fails + 1
END SUB

SUB printDiff (value$, actual$)
  PRINT " Expected:"; value$
  PRINT " Actual:"; actual$
END SUB

SUB expectEqualsStr (value$, actual$, message$)
  CALL addExpectation

  IF value$ = actual$ THEN
    pass (message$)
    EXIT SUB
  END IF

  fail message$
  printDiff value$, actual$
END SUB

SUB expectNotEqualsStr (value$, actual$, message$)
  addExpectation

  currentTest.expectationCount = currentTest.expectationCount + 1
  IF value$ <> actual$ THEN
    pass (message$)
    EXIT SUB
  END IF
  fail (message$)
  printDiff value$, actual$
END SUB

SUB expectEqualsInt (value%, actual%, message$)
  expectEqualsStr STR$(value%), STR$(actual%), message$
END SUB


SUB expectNotEqualsInt (value%, actual%, message$)
  expectNotEqualsStr STR$(value%), STR$(actual%), message$
END SUB

SUB expectEqualsLng (value&, actual&, message$)
  expectEqualsStr STR$(value&), STR$(actual&), message$
END SUB


SUB expectNotEqualsLng (value&, actual&, message$)
  expectNotEqualsStr STR$(value&), STR$(actual&), message$
END SUB

SUB test (testName$)
  currentTest.name = testName$
  currentTest.expectationCount = 0
END SUB

SUB endTest ()
  PRINT
  currentTest.name = "<Empty>"
  currentTest.expectationCount = 0
END SUB

SUB unit (unitName$)
  PRINT
  currentUnit.name = unitName$
  currentUnit.passes = 0
  currentUnit.fails = 0
END SUB

SUB endUnit ()
  PRINT "--------------------------"
  PRINT " "; RTRIM$(LTRIM$(currentUnit.name))
  PRINT "--------------------------"
  PRINT " Passes:  "; currentUnit.passes
  PRINT " Failures:"; currentUnit.fails
  PRINT
  currentUnit.name = "<Empty>"
  currentUnit.passes = 0
  currentUnit.fails = 0
END SUB
