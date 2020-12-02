$CONSOLE
_DEST _CONSOLE

unit "day1"

REDIM entries(1 TO 1) AS LONG

test "loadData"

DIM expectedEntries(1 TO 6) AS LONG
expectedEntries(1) = 1721
expectedEntries(2) = 979
expectedEntries(3) = 366
expectedEntries(4) = 299
expectedEntries(5) = 675
expectedEntries(6) = 1456

loadData "../data/day1.sample.txt", entries(), 6

FOR entryIndex% = LBOUND(expectedEntries) TO UBOUND(expectedEntries)
  expectEqualsLng expectedEntries(entryIndex%), entries(entryIndex%), "Index " + STR$(entryIndex%) + " is good"
NEXT entryIndex%

endTest

test "reportRepair"

expectEqualsLng 514579, reportRepair&(entries()), "Sample numbers produce sample answer"

endTest

endUnit

loadData "../data/day1.real.txt", entries(), 200
PRINT "VALUE="; reportRepair&(entries())

SYSTEM 0

'$include: '../lib/unit/unit.bas'

SUB loadData (fileName$, numbers&(), expectedCount%)
  DIM fileHandle AS INTEGER
  DIM dataLine AS LONG
  DIM numbersIndex AS INTEGER

  REDIM numbers&(1 TO expectedCount%)

  fileHandle = FREEFILE
  OPEN fileName$ FOR INPUT AS #fileHandle

  numbersIndex = 1
  FOR numbersIndex = 1 TO expectedCount%
    IF EOF(fileHandle) THEN
      _CONTINUE
    END IF
    INPUT #fileHandle, dataLine
    numbers&(numbersIndex) = dataLine
  NEXT numbersIndex
  CLOSE #fileHandle%
END SUB

FUNCTION reportRepair& (numbers&())
  DIM innerIndex AS INTEGER
  DIM outerIndex AS INTEGER
  DIM a AS LONG
  DIM b AS LONG

  reportRepair& = -1

  FOR outerIndex = LBOUND(numbers&) TO UBOUND(numbers&)
    FOR innerIndex = LBOUND(numbers&) TO UBOUND(numbers&)
      IF outerIndex = innerIndex THEN
        _CONTINUE
      END IF
      a = numbers&(outerIndex)
      b = numbers&(innerIndex)
      IF a + b = 2020 THEN
        reportRepair& = a * b
        EXIT FUNCTION
      END IF
    NEXT innerIndex
  NEXT outerIndex
END FUNCTION
