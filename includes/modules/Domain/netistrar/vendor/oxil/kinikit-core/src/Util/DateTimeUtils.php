<?php

namespace Kinikit\Core\Util;

/**
 * Generic helpful date time utils
 *
 * Class DateTimeUtils
 */
class DateTimeUtils {

    /**
     * Convert a date from one format to another
     *
     * @param $sourceFormat
     * @param $targetFormat
     * @param $value
     */
    public static function convertDate($sourceFormat, $targetFormat, $value) {
        $dateObject = date_create_from_format($sourceFormat, $value);
        if ($dateObject) {
            return $dateObject->format($targetFormat);
        } else {
            return null;
        }
    }


    /**
     * Convert seconds to an elapsed time value
     *
     * @param $seconds
     */
    public static function convertSecondsToElapsedTime($seconds) {

        // Hours component
        $hours = floor($seconds / 3600);

        // Minutes component
        $remainder = $seconds - ($hours * 3600);
        $minutes = floor($remainder / 60);

        // Seconds component
        $seconds = round($remainder - ($minutes * 60));


        return sprintf("%02d", $hours) . ":" . sprintf("%02d", $minutes) . ":" . sprintf("%02d", $seconds);

    }


    /**
     * Get the week beginning date (Monday) for a passed date.  If null is passed for the date the current date is assumed.
     * The date is returned in the date format supplied which defaults to d/m/Y
     *
     * @param string $date
     * @param string $dateFormat
     */
    public static function getWeekBeginningForDate($date = null, $dateFormat = 'd/m/Y') {
        if (!$date)
            $date = date($dateFormat);

        $dateObj = date_create_from_format($dateFormat, $date);

        $initialDay = $dateObj->format("w");
        $startDayOfWeek = $initialDay == 0 ? 6 : $initialDay - 1;

        // If we need to back track to monday, do that now.
        if ($startDayOfWeek > 0) {
            $dateObj->sub(new \DateInterval ("P" . $startDayOfWeek . "D"));
        }

        return $dateObj->format($dateFormat);
    }


}