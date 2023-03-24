{{> licence.dart }}

import '../../assets.dart';
import '../../base/common_mappers/error_mappers/error_mapper.dart';
import '../../base/models/errors/error_model.dart';
import '../../lib_auth/models/auth_token_model.dart';
import '../data_sources/remote/google_auth_data_source.dart';
import '../data_sources/remote/google_credential_data_source.dart';
import '../models/google_auth_request_model.dart';
import '../models/google_credentials_model.dart';

class GoogleAuthRepository {
  GoogleAuthRepository(this._googleAuthDataSource, this._errorMapper,
      this._googleCredentialDataSource);
  final GoogleAuthDataSource _googleAuthDataSource;
  final ErrorMapper _errorMapper;
  final GoogleCredentialDataSource _googleCredentialDataSource;

  Future<AuthTokenModel> googleAuth({
    required GoogleCredentialsModel googleAuthRequestModel,
  }) =>
      _errorMapper.execute(
        () => _googleAuthDataSource.googleAuth(
            GoogleAuthRequestModel.fromGoogleCredentials(
                googleAuthRequestModel)),
      );

  Future<GoogleCredentialsModel> getUsersGoogleCredential() async {
    final credentials =
        await _googleCredentialDataSource.getUsersGoogleCredential();
    if (credentials == null) {
      throw GenericErrorModel(I18nErrorKeys.googleAuthError);
    }
    return GoogleCredentialsModel.fromGoogleCredentials(credentials);
  }
}
