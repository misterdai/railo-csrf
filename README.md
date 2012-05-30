# CSRF Extension

http://www.getrailo.org/index.cfm/extensions/browse-extensions/csrf-session-tokens/

## Introduction

This extension provides two functions that help provide protection against CSRF attacks.  They work by generating a token that is associated with a URL or form, which is then verified when returned to the server.

## CsrfGenerateToken()

Function to generate a CSRF token, automatically storing it within the session (Currently as a key/token combination under session._csrfTokens).

### Arguments

* key (string, optional, defaults "") - Used to uniquely identify a token.  This is useful if you have a requirement to use CSRF tokens in several places, as each can be provided a unique token without interfering with each other.
* random (boolean, optional, defaults false) - False will only generate a fresh token on the first request (against the "key" argument), subsequent requests for a token will return the same token (until the session expires).  True will generate a fresh token for the key provided, each time the function is called, overwriting the previously generated token.

## CsrfVerifyToken()

This provides the functionality to verify tokens that have previously been generated.

### Arguments

* token (string, required) - The token that you wish to verify.
* key (string, optional, defaults "") - Key which identifies the token you're trying to verify.  This must be the same as the one that you called CsrfGenerateToken with.