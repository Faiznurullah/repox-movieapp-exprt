// import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class SSLPinningHelper {
  static Future<bool> certificatePinningCheck() async {
    try {
      // Temporarily disabled SSL pinning for development
      // TODO: Get actual certificate fingerprints from themoviedb.org
      
      /* 
      // List of allowed SHA256 fingerprints for themoviedb.org
      final List<String> allowedSHAFingerprints = [
        // TMDB certificate SHA256 fingerprint - PLACEHOLDER
        '1A:2B:3C:4D:5E:6F:7A:8B:9C:0D:1E:2F:3A:4B:5C:6D:7E:8F:9A:0B:1C:2D:3E:4F:5A:6B:7C:8D:9E:0F:1A:2B',
        // Backup certificate fingerprint - PLACEHOLDER
        '2B:3C:4D:5E:6F:7A:8B:9C:0D:1E:2F:3A:4B:5C:6D:7E:8F:9A:0B:1C:2D:3E:4F:5A:6B:7C:8D:9E:0F:1A:2B:3C',
      ];

      // Check certificate pinning for themoviedb.org
      await HttpCertificatePinning.check(
        serverURL: "https://api.themoviedb.org",
        headerHttp: {"Content-Type": "application/json"},
        sha: SHA.SHA256,
        allowedSHAFingerprints: allowedSHAFingerprints,
        timeout: 60,
      );
      */

      print('SSL Pinning check skipped for development');
      return true;
    } catch (e) {
      print('Certificate pinning check failed: $e');
      return false;
    }
  }

  static Future<void> init() async {
    await certificatePinningCheck();
  }
}
