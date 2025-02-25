package yukams.app.background_locator_2.provider

import android.location.Location
import android.os.Build
import com.google.android.gms.location.LocationResult
import yukams.app.background_locator_2.Keys

class LocationParserUtil {
    companion object {
        fun getLocationMapFromLocation(location: Location): HashMap<String, Any?> {
            var speedAccuracy = 0f
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                speedAccuracy = location.speedAccuracyMetersPerSecond
            }
            val kotlinNull: HashMap<String, Any?>?;


            kotlinNull = hashMapOf(
                Keys.ARG_IS_MOCKED to false,
                Keys.ARG_LATITUDE to location.latitude,
                Keys.ARG_LONGITUDE to location.longitude,
                Keys.ARG_ACCURACY to location.accuracy,
                Keys.ARG_ALTITUDE to location.altitude,
                Keys.ARG_SPEED to location.speed,
                Keys.ARG_SPEED_ACCURACY to speedAccuracy,
                Keys.ARG_HEADING to location.bearing,
                Keys.ARG_TIME to location.time.toDouble(),
                Keys.ARG_PROVIDER to location.provider,
            )
            return kotlinNull;
        }

        fun getLocationMapFromLocation(location: LocationResult?): java.util.HashMap<String, out Any?>? {
            val firstLocation = location?.lastLocation ?: return null;

            var speedAccuracy = 0f
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                speedAccuracy = firstLocation.speedAccuracyMetersPerSecond
            }

            return hashMapOf(
                Keys.ARG_IS_MOCKED to false,
                Keys.ARG_LATITUDE to firstLocation.latitude,
                Keys.ARG_LONGITUDE to firstLocation.longitude,
                Keys.ARG_ACCURACY to firstLocation.accuracy,
                Keys.ARG_ALTITUDE to firstLocation.altitude,
                Keys.ARG_SPEED to firstLocation.speed,
                Keys.ARG_SPEED_ACCURACY to speedAccuracy,
                Keys.ARG_HEADING to firstLocation.bearing,
                Keys.ARG_TIME to firstLocation.time.toDouble()
            )
        }
    }
}