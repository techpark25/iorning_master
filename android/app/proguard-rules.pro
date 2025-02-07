# Razorpay Keep Rules
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Google Wallet and PaymentsClient Keep Rules
-keep class com.google.android.apps.nbu.paisa.inapp.client.api.** { *; }
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.**

# Proguard Annotations Keep Rules
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }
