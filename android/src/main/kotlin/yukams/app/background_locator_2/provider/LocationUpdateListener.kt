package yukams.app.background_locator_2.provider

interface LocationUpdateListener {
    fun onLocationUpdated(location: HashMap<String, Any>?)
}