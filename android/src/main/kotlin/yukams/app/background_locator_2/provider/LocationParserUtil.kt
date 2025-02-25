package yukams.app.background_locator_2.provider

import android.os.Build
import androidx.annotation.RequiresApi
import com.google.android.gms.location.LocationResult
import yukams.app.background_locator_2.Keys

class LocationParserUtil {
    companion object {

        @RequiresApi(Build.VERSION_CODES.S)
        fun getLocationMapFromLocation(location: LocationResult?): HashMap<String, Any>? {
            val firstLocation = location?.lastLocation ?: return null;

            var speedAccuracy = 0f
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                speedAccuracy = firstLocation.speedAccuracyMetersPerSecond
            }


            val isMocked: Boolean = if (Build.VERSION.SDK_INT > Build.VERSION_CODES.S) {
                firstLocation.isMock
            } else {
                firstLocation.isFromMockProvider
            }

            return hashMapOf(
                Keys.ARG_IS_MOCKED to isMocked,
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