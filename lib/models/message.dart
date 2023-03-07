class ISOInput {
  String iso;
  int mode;
  int lengthHeader;
  ISOInput({required this.iso, required this.mode, required this.lengthHeader});

  Map toJson() => {"iso": iso, "mode": mode, "lengthHeader": lengthHeader};
}
