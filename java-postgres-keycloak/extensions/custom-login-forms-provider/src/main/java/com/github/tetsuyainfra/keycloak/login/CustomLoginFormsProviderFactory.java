package com.github.tetsuyainfra.keycloak.login;

import org.keycloak.forms.login.LoginFormsProvider;
import org.keycloak.forms.login.freemarker.FreeMarkerLoginFormsProviderFactory;
import org.keycloak.models.KeycloakSession;

/**
 * This has same providerID like built-in ValidateUsername provider. But it
 * should be called in favour of ValidateUsername even
 * if it doesn't have "order" set. As it is custom provider and it worked this
 * way in previous versions
 */
public class CustomLoginFormsProviderFactory extends FreeMarkerLoginFormsProviderFactory {

    @Override
    public LoginFormsProvider create(KeycloakSession session) {
        return new CustomLoginFormsProvider(session);
    }

    @Override
    public String getId() {
        return "custom-login-forms-provider";
    }

    @Override
    public int order() {
        return 1;
    }
}