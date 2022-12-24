class UIAssets {
  static const String imageDir = "assets/images";
  static const String gifDir = "assets/gif";
  static const String svgDir = "assets/svg";
  static const String animDir = "assets/anim";

  static const String appLogo = "$imageDir/app_logo.png";
  static const String appLongLogo = "$imageDir/long-logo.png";

  static const String placeHolderImage = "$imageDir/image-load-error.png";
  static const String termsandconditionImage =
      "$imageDir/terms-and-conditions.png";

  static const String privacypolicyImage = "$imageDir/compliant.png";
  static const String contactUs = "$imageDir/contact.png";

  static const String gifLoading = "$gifDir/loading.gif";
  static const String errorAnimation = "$animDir/error.json";
  static const String editIcon = "$svgDir/edit-icon.svg";
  static const String circularEditIcon = "$svgDir/circular_edit_icon.svg";

  static String getImage(String imageName) {
    return "$imageDir/$imageName";
  }

  static String getSvg(String svgName) {
    return "$svgDir/$svgName";
  }
}
