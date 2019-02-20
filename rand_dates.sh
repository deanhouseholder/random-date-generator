#!/bin/bash

# Display Help Documentation
if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
  echo "Script Syntax:"
  echo "rand_dates.sh [count] [date_format] [start_year] [end_year]"
  echo "  [count]          The number of dates to generate"
  echo "  [date_format]    Date Format string or number (See Date Formats section)"
  echo "  [start_year]     Starting 4-digit year"
  echo "  [end_year]       Ending 4-digit year"
  echo
  echo "Date Formats:"
  echo "  Day"
  echo "    d | Day of the month, 2 digits with leading zeros            | 01 to 31"
  echo "    j | Day of the month without leading zeros                   | 1 to 31"
  echo "  Month"
  echo "    M | A short textual representation of a month, three letters | Jan through Dec"
  echo "    U | An uppercase representation of a month, three letters    | JAN through DEC"
  echo "    m | Numeric representation of a month, with leading zeros    | 01 through 12"
  echo "    n | Numeric representation of a month, without leading zeros | 1 through 12"
  echo "  Year"
  echo "    Y | A full numeric representation of a year, 4 digits        | Examples: 1999 or 2003"
  echo "    y | A two digit representation of a year                     | Examples: 99 or 03"
  echo "    L | Whether it's a leap year                                 | 1 if it is a leap year, 0 otherwise"
  echo
  echo "Pre-defined Date Formats:"
  echo "  1 = Y-m-d  (2015-07-05)"
  echo "  2 = d-U-Y  (05-JUL-2015)"
  echo "  3 = j M y  (5 Jul 15)"
  echo "  4 = M j, Y (Jul 5, 2015)"
  echo
  exit
fi


##################
## Begin Script ##
##################

# If user passed in a number to this script generate that many random dates otherwise generate 1
[[ ! -z "$1" ]] && count="$1" || count=1

# Determine date format
format1='Y-m-d'
format2='d-U-Y'
format3='j M y'
format4='M j, Y'

if [[ ! -z "$2" ]]; then
  if [[ "$2" == "1" ]]; then
    format="$format1"
  elif [[ "$2" == "2" ]]; then
    format="$format2"
  elif [[ "$2" == "3" ]]; then
    format="$format3"
  elif [[ "$2" == "4" ]]; then
    format="$format4"
  else
    # Accept the format they pass in
    format="$2"
  fi
else
  # Default to Format1
  format="$format1"
fi

# Define start and end years if requested
[[ ! -z $3 ]] && start_year=$3 || start_year=2000
[[ ! -z $4 ]] && end_year=$4 || end_year=$(date +%Y)

# Define the number of days in each month
JAN=31
FEB=28
MAR=31
APR=30
MAY=31
JUN=30
JUL=31
AUG=31
SEP=30
OCT=31
NOV=30
DEC=31


###############
## Functions ##
###############

# Function is_leap_year
# Determine if the year is a leap year
#
# @param1 Year (2015)
# @return bool
function is_leap_year() {
  if [[ $(date -d "Dec 31, $1" +%j) -eq 366 ]]; then
    echo 1
  else
    echo 0
  fi
}

# Function display_date
# Display the given date according to a format
#
# @param1 Date Format (Y-m-d)
# @param2 Year (2015)
# @param3 Uppercase Month (MAY)
# @param4 Day (05)
# @return string
function display_date() {
  format="$1"

  # Year Logic
  year=$2
  year_short=${year:2:3}
  leap_year=$(is_leap_year $year)

  # Month Logic
  months_upper=(XXX JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC)
  months_cap=(XXX Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
  month=$3
  for i in $(seq 12); do
    [[ $month == ${months_upper[$i]} ]] \
      && month_cap=${months_cap[$i]} \
      && month_numeric=$i \
      && month_padded=$i
  done
  [[ $month_padded -lt 10 ]] && month_padded=0$month_padded

  # Day Logic
  day_padded=$4
  day_numeric=$(echo $day_padded | sed -e 's/^0//')

  # Swap out date format letters with actual values
  # (Any values with letters as output needs to go last)
  output="$(echo "$format" | sed \
    -e "s~Y~$year~g" \
    -e "s~y~$year_short~g" \
    -e "s~L~$leap_year~g" \
    -e "s~m~$month_padded~g" \
    -e "s~n~$month_numeric~g" \
    -e "s~d~$day_padded~g" \
    -e "s~j~$day_numeric~g" \
    -e "s~M~$month_cap~g" \
    -e "s~U~$month~g" \
  )"

  echo "$output"
}

# Function rand_nums
# Generate a random set of numbers within a range
#
# @param1 start value
# @param2 end value
# @param3 number of random values to generate (Default: 1)
# @return array of numbers
function rand_nums() {
  if [[ -z $1 ]] || [[ -z $2 ]]; then
    echo -e "\nError: Missing required arguments.\n\nSyntax:\n$0 [start] [end] [count]\n"
    exit
  fi

  # Define variables
  start=$1
  end=$2
  [[ ! -z $3 ]] && count=$3 || count=1

  # Check to make sure $end is bigger than $start
  if [[ $end -le $start ]]; then
    echo -e "\nError: Ending value must be greater than starting value.\n"
    exit
  fi
  diff=$(($end-$start+1))

  # Generate $count random numbers
  for i in $(seq $count); do
    echo $(($(($RANDOM%$diff))+$start))
  done
}

# Function rand_day
# Generate a random set of days of a month below a max date
#
# @param1 = max date (default: 28)
# @param2 = number of random days to generate (Default: 1)
# @return array of numbers
function rand_day() {
  [[ ! -z $1 ]] && highest_date=$1 || highest_date=28
  [[ ! -z $2 ]] && count=$2 || count=1
  for i in $(rand_nums 1 $highest_date $count); do
    if [[ $i -lt 10 ]]; then
      echo 0$i
    else
      echo $i
    fi
  done
}

# Function rand_month
# Generate a random set of months
#
# @param1 = number of random months to generate
# @return array of strings
function rand_month() {
  [[ ! -z $1 ]] && count=$1 || count=1
  months=(JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC)
  for i in $(rand_nums 0 11 $count); do
    echo ${months[$i]}
  done
}

# Function rand_year
# Generate a random set of years between a start year and end year
#
# @param1 = starting year (Default: 2000)
# @param2 = ending year (Default: [current year])
# @param3 = number of random years to generate (Default: 1)
# @return array of numbers
function rand_year() {
  [[ ! -z $1 ]] && start_year=$1 || start_year=2000
  [[ ! -z $2 ]] && end_year=$2 || end_year=$(date +%Y)
  [[ ! -z $3 ]] && count=$3 || count=1
  rand_nums $start_year $end_year $count
}

# Function rand_date
# Generate a random set of dates between a start year and end year and output according to a format
#
# @param1 = number of random dates to generate
# @return array of strings
function rand_date() {
  [[ ! -z $1 ]] && count=$1 || count=1
  [[ ! -z "$2" ]] && format="$2"
  rand_months=($(rand_month $count))
  rand_years=($(rand_year $start_year $end_year $count))

  for i in $(seq 0 $((count - 1))); do
    # Logic to add a day to Feb on leap years
    year=${rand_years[$i]}
    leap=$(is_leap_year $year)
    month=${rand_months[$i]}
    month_days=${!rand_months[$i]}
    if [[ $leap -eq 1 ]] && [[ "$month" == "FEB" ]]; then
      month_days=29
    fi
    day=$(rand_day $month_days)

    # Display the date according to the date format selected
    display_date "$format" $year $month $day
  done
}


########################
## Call Main Function ##
########################

rand_date $count "$format"
