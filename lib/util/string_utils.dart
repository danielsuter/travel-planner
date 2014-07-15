library string_utils;

class StringUtils {
  static bool isEmpty(String s) {
    if(s == null) return true;
    
    return s == "";
  }
}