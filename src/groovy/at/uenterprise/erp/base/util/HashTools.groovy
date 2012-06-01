/**
 * User: mkuhl
 * Date: 11.07.2009
 * Time: 15:59:27
 * Description:
 */
package at.uenterprise.erp.base.util

import java.security.MessageDigest

final class HashTools {

  public static String SHA(String s) { SHA(s.getBytes()) ; }

  public static String SHA(byte[] bytes) {
    MessageDigest md = MessageDigest.getInstance("SHA");
    md.update(bytes, 0, bytes.length);
    byte[] hash = md.digest();
    return encodeHex(hash)
  }


  public static String encodeHex(final byte[] data) {
      StringBuilder sb = new StringBuilder(data.length*2);

      for (int i = 0; i < data.length; i++) {
          // convert byte into unsigned hex string
          String hexString = Integer.toHexString(data[i] & 0xFF);
          // add leading zero if the length of the string is one
          if (hexString.length() < 2) {
              sb.append("0");
          }
          // write hex string to writer
          sb.append(hexString);
      }
      return sb.toString();
  }


}