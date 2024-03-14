// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Bomber VPN`
  String get logo {
    return Intl.message(
      'Bomber VPN',
      name: 'logo',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get Create_an_account {
    return Intl.message(
      'Create an account',
      name: 'Create_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Log in with an existing account`
  String get Log_in_with_an_existing_account {
    return Intl.message(
      'Log in with an existing account',
      name: 'Log_in_with_an_existing_account',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get log_in {
    return Intl.message(
      'Log in',
      name: 'log_in',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get dont_have_an_account {
    return Intl.message(
      'Don’t have an account?',
      name: 'dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_password {
    return Intl.message(
      'Reset password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Remembered your password?`
  String get remembered_your_password {
    return Intl.message(
      'Remembered your password?',
      name: 'remembered_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `By creating an account, you have agree to our`
  String get by_creating_an_account {
    return Intl.message(
      'By creating an account, you have agree to our',
      name: 'by_creating_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service & Privacy Policy`
  String get terms_of_service {
    return Intl.message(
      'Terms of Service & Privacy Policy',
      name: 'terms_of_service',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email`
  String get please_verify_your_email {
    return Intl.message(
      'Please verify your email',
      name: 'please_verify_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get verified {
    return Intl.message(
      'Verified',
      name: 'verified',
      desc: '',
      args: [],
    );
  }

  /// `Resend email`
  String get resend {
    return Intl.message(
      'Resend email',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with a different email`
  String get sign_up_with_a_different_email {
    return Intl.message(
      'Sign up with a different email',
      name: 'sign_up_with_a_different_email',
      desc: '',
      args: [],
    );
  }

  /// `This information is only available on your device`
  String get this_information_is_only_available_on_your_device {
    return Intl.message(
      'This information is only available on your device',
      name: 'this_information_is_only_available_on_your_device',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Get access to unlimited speed and premium locations`
  String get get_access_to_unlimited_speed_and_premium_locations {
    return Intl.message(
      'Get access to unlimited speed and premium locations',
      name: 'get_access_to_unlimited_speed_and_premium_locations',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Connection Mode`
  String get connection_mode {
    return Intl.message(
      'Connection Mode',
      name: 'connection_mode',
      desc: '',
      args: [],
    );
  }

  /// `OpenVPN`
  String get open_vpn {
    return Intl.message(
      'OpenVPN',
      name: 'open_vpn',
      desc: '',
      args: [],
    );
  }

  /// `Kill Switch`
  String get kill_switch {
    return Intl.message(
      'Kill Switch',
      name: 'kill_switch',
      desc: '',
      args: [],
    );
  }

  /// `Block internet when connecting or changing servers`
  String get block_internet_when_connecting_or_changing_servers {
    return Intl.message(
      'Block internet when connecting or changing servers',
      name: 'block_internet_when_connecting_or_changing_servers',
      desc: '',
      args: [],
    );
  }

  /// `Connection`
  String get connection {
    return Intl.message(
      'Connection',
      name: 'connection',
      desc: '',
      args: [],
    );
  }

  /// `Connect when Bomber VPN starts`
  String get connect_when_prime_vpn_starts {
    return Intl.message(
      'Connect when Bomber VPN starts',
      name: 'connect_when_prime_vpn_starts',
      desc: '',
      args: [],
    );
  }

  /// `Show notification when Bomber VPN is not connected`
  String get show_notification_when_prime_vpn_is_not_connected {
    return Intl.message(
      'Show notification when Bomber VPN is not connected',
      name: 'show_notification_when_prime_vpn_is_not_connected',
      desc: '',
      args: [],
    );
  }

  /// `Premium features`
  String get premium_features {
    return Intl.message(
      'Premium features',
      name: 'premium_features',
      desc: '',
      args: [],
    );
  }

  /// `Anonymous`
  String get anonymous {
    return Intl.message(
      'Anonymous',
      name: 'anonymous',
      desc: '',
      args: [],
    );
  }

  /// `Hide your ip with anonymous surfing`
  String get hide_your_ip_with_anonymous_surfing {
    return Intl.message(
      'Hide your ip with anonymous surfing',
      name: 'hide_your_ip_with_anonymous_surfing',
      desc: '',
      args: [],
    );
  }

  /// `Fast`
  String get fast {
    return Intl.message(
      'Fast',
      name: 'fast',
      desc: '',
      args: [],
    );
  }

  /// `Up to 1000 Mb/s bandwidth to explore`
  String get up_to_mb_s_bandwidth_to_explore {
    return Intl.message(
      'Up to 1000 Mb/s bandwidth to explore',
      name: 'up_to_mb_s_bandwidth_to_explore',
      desc: '',
      args: [],
    );
  }

  /// `Remove Ads`
  String get remove_ads {
    return Intl.message(
      'Remove Ads',
      name: 'remove_ads',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy the app without annoying ads`
  String get enjoy_the_app_without_annoying_ads {
    return Intl.message(
      'Enjoy the app without annoying ads',
      name: 'enjoy_the_app_without_annoying_ads',
      desc: '',
      args: [],
    );
  }

  /// `Secure`
  String get secure {
    return Intl.message(
      'Secure',
      name: 'secure',
      desc: '',
      args: [],
    );
  }

  /// `Transfer traffic viaencrypted tunnel`
  String get transfer_traffic_viaencrypted_tunnel {
    return Intl.message(
      'Transfer traffic viaencrypted tunnel',
      name: 'transfer_traffic_viaencrypted_tunnel',
      desc: '',
      args: [],
    );
  }

  /// `1 MONTH`
  String get one_month {
    return Intl.message(
      '1 MONTH',
      name: 'one_month',
      desc: '',
      args: [],
    );
  }

  /// `1 YEAR`
  String get one_year {
    return Intl.message(
      '1 YEAR',
      name: 'one_year',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get month {
    return Intl.message(
      'month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `TRY PREMIUM FREE`
  String get try_premium_free {
    return Intl.message(
      'TRY PREMIUM FREE',
      name: 'try_premium_free',
      desc: '',
      args: [],
    );
  }

  /// `7-day free trial. Then 9.99`
  String get seven_days {
    return Intl.message(
      '7-day free trial. Then 9.99',
      name: 'seven_days',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Freemium locations`
  String get freemium_locations {
    return Intl.message(
      'Freemium locations',
      name: 'freemium_locations',
      desc: '',
      args: [],
    );
  }

  /// `Premium locations`
  String get premium_locations {
    return Intl.message(
      'Premium locations',
      name: 'premium_locations',
      desc: '',
      args: [],
    );
  }

  /// `Connect by ping`
  String get connect_by_ping {
    return Intl.message(
      'Connect by ping',
      name: 'connect_by_ping',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect`
  String get disconnect {
    return Intl.message(
      'Disconnect',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `Status: connected`
  String get status_connected {
    return Intl.message(
      'Status: connected',
      name: 'status_connected',
      desc: '',
      args: [],
    );
  }

  /// `Status: not connected`
  String get status_not_connected {
    return Intl.message(
      'Status: not connected',
      name: 'status_not_connected',
      desc: '',
      args: [],
    );
  }

  /// `SELECT LOCATION`
  String get select_location {
    return Intl.message(
      'SELECT LOCATION',
      name: 'select_location',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Server not connected`
  String get server_not_connected {
    return Intl.message(
      'Server not connected',
      name: 'server_not_connected',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get Send {
    return Intl.message(
      'Send',
      name: 'Send',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
