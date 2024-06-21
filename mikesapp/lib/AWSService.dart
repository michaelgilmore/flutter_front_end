import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AWSService {
  final UserPool = CognitoUserPool(
    '${(dotenv.env['POOL_ID'])}',
    '${(dotenv.env['CLIENT_ID'])}'
  );

  Future<bool> signUp(String username, String password, String email) async {
    final userAttributes = [
      AttributeArg(name: 'email', value: email)
    ];

    try {
      await UserPool.signUp(username, password, userAttributes: userAttributes);
      return true;
    } on CognitoClientException catch (e) {
      print(e);
    } on CognitoUserException catch (e) {
      print(e);
    } catch(e) {
      print(e);
    }
    return false;
  }

  Future<bool> signIn(String username, String password) async {

    final cognitoUser = CognitoUser(username, UserPool);
    final authDetails = AuthenticationDetails(
      username: username,
      password: password
    );

    CognitoUserSession? session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
      return true;
    } on CognitoClientException catch (e) {
      print(e);
    } on CognitoUserException catch (e) {
      print(e);
    }/*( on CognitoUserConfirmationNecessaryException catch (e) {
      print(e);
    } on CognitoUserNewPasswordRequiredException catch (e) {
      print(e);
    } on CognitoUserMfaRequiredException catch (e) {
      print(e);
    } on CognitoUserPasswordResetRequiredException catch (e) {
      print(e);
    } on CognitoUserNotConfirmedException catch (e) {
      print(e);
    } on CognitoUserNotFoundException catch (e) {
      print(e);
    } on CognitoUserInvalidPasswordException catch (e) {
      print(e);
    } on CognitoUserInvalidParameterException catch (e) {
      print(e);
    } on CognitoUserLimitExceededException catch (e) {
      print(e);
    } on CognitoUserCodeMismatchException catch (e) {
      print(e);
    } on CognitoUserExpiredCodeException catch (e) {
      print(e);
    } on CognitoUserNotAuthorizedException catch (e) {
      print(e);
    } on CognitoUserInternalErrorException catch (e) {
      print(e);
    } on CognitoUserResourceNotFoundException catch (e) {
      print(e);
    } on CognitoUserUnexpectedLambdaException catch (e) {
      print(e);
    } on CognitoUserUserLambdaValidationException catch (e) {
      print(e);
    } on CognitoUserPasswordVerifierException catch (e) {
      print(e);
    } on CognitoUserAliasExistsException catch (e) {
      print(e);
    } on CognitoUserCodeDeliveryFailureException catch (e) {
      print(e);
    } on CognitoUserInvalidLambdaResponseException catch (e) {
      print(e);
    } on CognitoUserTooManyFailedAttemptsException catch (e) {
      print(e);
    } on CognitoUserUnexpectedException catch (e) {
      print(e);
    } on CognitoUserUserNotConfirmedException catch (e) {
      print(e);
    } on CognitoUserPasswordResetRequiredException catch (e) {
      print(e);
    } on CognitoUserInvalidSmsRoleAccessPolicyException catch (e) {
      print(e);
    }
    */
    catch(e) {
      print(e);
    }
    return false;
  }
}