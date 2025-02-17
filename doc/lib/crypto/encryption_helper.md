# Encryption helper

Encryption helper allows to perform common encryption operations such as RSA/AES encryption and decryption.

## Provided operations

Below you can find the encryption helper's provided operations with some examples

1. Encrypts the given **string** `data` with AES using the specified `key`

    ```dart
    static Uint8List encryptStringWithAes(String data, Uint8List key)
    ```

2. Encrypts the given **string** `data` with AES-GCM mode using the specified `key`

    ```dart
    static Uint8List encryptStringWithAesGCM(String data, Uint8List key)
    ```

3. Encrypts the given **bytes** `data` with AES using the specified `key`
  
    ```dart
    static Uint8List encryptBytesWithAes(Uint8List data, Uint8List key)
    ```

4. Decrypts the given **bytes** `data` with AES using the specified `key`

    ```dart
    static Uint8List decryptWithAes(Uint8List data, Uint8List key)
    ```

5. Encrypts the given **string** `data` with RSA using the specified `key`

    ```dart
    static Uint8List encryptStringWithRsa(String data, RSAPublicKey key)
    ```

6. Encrypts the given **bytes** `data` with RSA using the specified `key`

    ```dart
    static Uint8List encryptBytesWithRsa(Uint8List data, RSAPublicKey key)
    ```

7. Decrypts the given **bytes** `data` with RSA using the specified private `key`

    ```dart
    static Uint8List decryptBytesWithRsa(Uint8List data, RSAPrivateKey key)
    ```

8. Returns the RSA Public key associated to the government that should be used when encrypting the data that only it should see

    ```dart
    static Future<VowRSAPublicKey> getGovernmentRsaPubKey(
        Uri lcdUrl, {
        http.Client? client,
    })
    ```
