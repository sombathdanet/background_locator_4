package yukams.app.background_locator_2.provider

enum class LocationClient(val value: Int) {
    Google(0);

    companion object {
        fun fromInt(value: Int) = values().firstOrNull { it.value == value }
    }
}