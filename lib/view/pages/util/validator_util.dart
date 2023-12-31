import 'package:get/get.dart';
import 'package:validators/validators.dart';

Function validateUsername() {
  return (String? value) {
    if (value!.isEmpty) {
      return "유저네임에 공백이 들어갈 수 없습니다.";
    } else if (!isAlphanumeric(value)) {
      return "유저네임에 한글이나 특수문자가 들어갈 수 없습니다";
    } else if (value.length > 12) {
      return "유저네임 길이를 초과하였습니다.";
    } else if (value.length < 4) {
      return "유저네임의 최소 길이는 4자입니다.";
    } else {
      return null;
    }
  };
}

Function validatePassword() {
  return (String? value) {
    if (value!.isEmpty) {
      return "패스워드에 공백이 들어갈 수 없습니다.";
    } else if (!isAlphanumeric(value)) {
      return "패스워드에 한글이 들어갈 수 없습니다";
    } else if (value.length > 12) {
      return "패스워드 길이를 초과하였습니다.";
    } else if (value.length < 4) {
      return "패스워드의 최소 길이는 4자입니다.";
    } else {
      return null;
    }
  };
}

Function validateEmail() {
  return (String? value) {
    if (value!.isEmpty) {
      return "이메일에 공백이 들어갈 수 없습니다.";
    } else if (!value.isEmail) {
      return "이메일 형식에 맞지 않습니다.";
    } else if (value.length > 50) {
      return "길이를 초과하였습니다.";
    } else if (value.length < 4) {
      return "이메일의 최소 길이는 4자입니다.";
    } else {
      return null;
    }
  };
}

Function validateTitle() {
  return (String? value) {
    if (value!.isEmpty) {
      return "제목은 공백이 들어갈 수 없습니다.";
    } else if (value.length > 30) {
      return "제목의 길이를 초과하였습니다.";
    } else {
      return null;
    }
  };
}

Function validateContent() {
  return (String? value) {
    if (value!.isEmpty) {
      return "내용은 공백이 들어갈 수 없습니다.";
    } else if (value.length > 500) {
      return "내용의 길이를 초과하였습니다.";
    } else {
      return null;
    }
  };
}
