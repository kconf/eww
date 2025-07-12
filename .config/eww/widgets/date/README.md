# Date Widget Documentation

## Overview
The date widget now provides comprehensive date and time information through a JSON object that updates every 60 seconds.

## JSON Structure

The `time-poll` variable contains the following fields:

### Date Fields
- `year`: Four-digit year (e.g., "2025")
- `month`: Month number with leading zero (e.g., "07")
- `day`: Day of month with leading zero (e.g., "13")
- `month_name`: Full month name (e.g., "July")
- `month_short`: Abbreviated month name (e.g., "Jul")

### Day of Week
- `weekday`: Full weekday name (e.g., "Sunday")
- `weekday_short`: Abbreviated weekday name (e.g., "Sun")

### Time Fields
- `hour`: 24-hour format with leading zero (e.g., "00")
- `minute`: Minutes with leading zero (e.g., "13")
- `second`: Seconds with leading zero (e.g., "43")
- `hour_12`: 12-hour format with leading zero (e.g., "12")
- `ampm`: AM/PM indicator (e.g., "AM")

### Additional Fields
- `timezone`: Timezone abbreviation (e.g., "CST")
- `iso_date`: ISO date format (e.g., "2025-07-13")
- `iso_datetime`: ISO datetime format (e.g., "2025-07-13T00:13:43+0800")
- `timestamp`: Unix timestamp (e.g., "1752336823")

## Usage Examples

### Basic Time Display
```yuck
(label :text "${time-poll.hour}:${time-poll.minute}")
```

### 12-Hour Format
```yuck
(label :text "${time-poll.hour_12}:${time-poll.minute} ${time-poll.ampm}")
```

### Full Date Display
```yuck
(label :text "${time-poll.weekday}, ${time-poll.month_name} ${time-poll.day}, ${time-poll.year}")
```

### Short Date Format
```yuck
(label :text "${time-poll.month_short} ${time-poll.day}")
```

### ISO Date Format
```yuck
(label :text "${time-poll.iso_date}")
```

## Available Widgets

### Core Widgets
- `time`: Basic time display with hover calendar
- `calendar-popup`: Enhanced calendar with date header

### Additional Widgets
- `date-simple`: Simple date display (Month Day)
- `date-full`: Full date and time display
- `time-12h`: 12-hour time format
- `weekday`: Day of week display
- `digital-clock`: Digital clock with date

## Example Usage in Bar

```yuck
(defwidget bar []
  (box :class "bar"
       :orientation "h"
    (time)           ;; Main time widget
    (date-simple)    ;; Simple date
    (weekday)))      ;; Day of week
```

## Customization

You can easily create custom date/time displays by combining different fields:

```yuck
(defwidget custom-datetime []
  (box :orientation "v"
    (label :text "${time-poll.weekday_short} ${time-poll.month}/${time-poll.day}")
    (label :text "${time-poll.hour}:${time-poll.minute}")))
```

## Performance
- Updates every 60 seconds
- Single `date` command execution
- JSON parsing handled by eww
- All date/time information available simultaneously
