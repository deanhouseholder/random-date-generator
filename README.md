# Random Date Generator

_____

Generate random dates in your bash terminal.


## Examples

Request 10 random dates between 1980 and 2015 with a date format of 'Y-M-d':

```bash
$ ./rand_dates.sh 10 'Y-M-d' 1980 2015
2002-Apr-13
2014-Jun-18
2010-Feb-18
2009-Apr-19
2005-Jun-27
1995-Nov-02
1986-Jan-01
1989-Feb-13
1983-Sep-10
2015-Jan-30
```

Request 15 random dates using date format preset #1 (assume defaults of years between 2000 and the current year)

```bash
$ ./rand_dates.sh 15 1
2016-01-11
2014-04-15
2013-10-30
2001-09-08
2008-02-04
2011-11-08
2014-05-17
2010-09-09
2005-08-09
2006-08-25
2017-03-27
2016-10-01
2006-12-28
2003-02-03
2004-09-28
```



## Usage

`rand_dates.sh [count] [date_format] [start_year] [end_year]`

| Parameter     | Description                                        |
| ------------- | -------------------------------------------------- |
| [count]       | The number of dates to generate                    |
| [date_format] | Date Format string or number (See Formats section) |
| [start_year]  | Starting 4-digit year                              |
| [end_year]    | Ending 4-digit year                                |



## Date Formats

You can specify a response date format string in any of the following options:

| Symbol    | Description                                              | Example                        |
| --------- | -------------------------------------------------------- | ------------------------------ |
| Day       |                                                          |                                |
| d         | Day of the month, 2 digits with leading zeros            | 01 to 31                       |
| j         | Day of the month without leading zeros                   | 1 to 31                        |
|  |  |  |
| Month     |                                                          |                                |
| M         | A short textual representation of a month, three letters | Jan through Dec                |
| U         | An uppercase representation of a month, three letters    | JAN through DEC                |
| m         | Numeric representation of a month, with leading zeros    | 01 through 12                  |
| n         | Numeric representation of a month, without leading zeros | 1 through 12                   |
|  |  |  |
| Year      |                                                          |                                |
| Y         | A full numeric representation of a year, 4 digits        | Examples: 1999 or 2003         |
| y         | A two digit representation of a year                     | Examples: 99 or 03             |
| L         | Whether it's a leap year                                 | 1 for a leap year, 0 otherwise |



## Pre-defined Date Formats

| Number | Format String | Example Output |
| ------ | ------------- | -------------- |
| 1      | Y-m-d         | 2015-07-05     |
| 2      | d-U-Y         | 05-JUL-2015    |
| 3      | j M y         | 5 Jul 15       |
| 4      | M j, Y        | Jul 5, 2015    |



## Displaying Help

```bash
rand_dates.sh -h
```



## Note

This script takes into consideration leap years and will allow Feb 29th if randomly generated date occurs during a leap year.



## License

MIT License

Copyright (c) 2019 Dean Householder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.