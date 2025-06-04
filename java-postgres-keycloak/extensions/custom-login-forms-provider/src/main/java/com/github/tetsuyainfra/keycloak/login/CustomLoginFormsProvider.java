package com.github.tetsuyainfra.keycloak.login;

import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriBuilder;
import org.jboss.logging.Logger;
import org.keycloak.forms.login.LoginFormsPages;
import org.keycloak.forms.login.freemarker.FreeMarkerLoginFormsProvider;
import org.keycloak.forms.login.freemarker.model.AuthenticationSessionBean;
import org.keycloak.forms.login.freemarker.model.LoginBean;
import org.keycloak.forms.login.freemarker.model.OAuthGrantBean;
import org.keycloak.models.KeycloakSession;
import org.keycloak.models.UserModel;
import org.keycloak.sessions.AuthenticationSessionModel;
import org.keycloak.theme.Theme;
import java.io.IOException;
import java.util.Locale;
import java.util.Properties;

import com.github.tetsuyainfra.keycloak.login.model.UserBean;

public class CustomLoginFormsProvider extends FreeMarkerLoginFormsProvider {
    private static final Logger logger = Logger.getLogger(CustomLoginFormsProvider.class);

    public CustomLoginFormsProvider(KeycloakSession session) {
        super(session);
    }

    @Override
    public Response createOAuthGrant() {
        logger.info("CustomLoginFormsProvider.createOAuthGrant called");
        return _createResponse(LoginFormsPages.OAUTH_GRANT);
    }

    private Response _createResponse(LoginFormsPages page) {
        Theme theme;
        try {
            theme = getTheme();
        } catch (IOException e) {
            logger.error("Failed to create theme", e);
            return Response.serverError().build();
        }

        Locale locale = session.getContext().resolveLocale(user);
        Properties messagesBundle = handleThemeResources(theme, locale);

        handleMessages(locale, messagesBundle);

        // for some reason Resteasy 2.3.7 doesn't like query params and form params with
        // the same name and will null out the code form param
        UriBuilder uriBuilder = prepareBaseUriBuilder(page == LoginFormsPages.OAUTH_GRANT);
        createCommonAttributes(theme, locale, messagesBundle, uriBuilder, page);

        attributes.put("login", new LoginBean(formData));
        if (status != null) {
            attributes.put("statusCode", status.getStatusCode());
        }

        // OAUTH_GRANTでは有効になっているっぽい
        if (!isDetachedAuthenticationSession()) {
            if ((AuthenticationSessionModel.Action.AUTHENTICATE.name().equals(authenticationSession.getAction())) ||
                    (AuthenticationSessionModel.Action.REQUIRED_ACTIONS.name()
                            .equals(authenticationSession.getAction()))
                    ||
                    (AuthenticationSessionModel.Action.OAUTH_GRANT.name().equals(authenticationSession.getAction()))) {
                setAttribute("authenticationSession", new AuthenticationSessionBean(
                        authenticationSession.getParentSession().getId(), authenticationSession.getTabId()));
            }
        }

        switch (page) {
            case OAUTH_GRANT:
                attributes.put("myuser", "myuserString");
                UserModel authenticatedUser = this.authenticationSession.getAuthenticatedUser();
                if (authenticatedUser != null) {
                    attributes.put("user", new UserBean(authenticatedUser));
                }
                attributes.put("oauth",
                        new OAuthGrantBean(accessCode, client, clientScopesRequested));
                break;
            default:
                logger.error("Unsupported page: " + page);
                return Response.serverError().build();
        }

        return processTemplate(theme, "login-oauth-grant.ftl", locale);
    }

    private boolean isDetachedAuthenticationSession() {
        return detachedAuthSession || authenticationSession == null;
    }

    @Override
    public CustomLoginFormsProvider setAuthenticationSession(AuthenticationSessionModel authenticationSession) {
        logger.info("CustomLoginFormsProvider.setAuthenticationSession: " + String.valueOf(authenticationSession));
        this.authenticationSession = authenticationSession;
        return this;
    }

    @Override
    public CustomLoginFormsProvider setUser(UserModel user) {
        logger.info("CustomLoginFormsProvider.setUser: " + String.valueOf(user));
        this.user = user;
        return this;
    }
}



// example
// https://github.com/keycloak/keycloak/blob/a66f7fbc53d742ebf049e47c05075a4c79f273da/testsuite/integration-arquillian/servers/auth-server/services/testsuite-providers/src/main/java/org/keycloak/examples/providersoverride/CustomLoginFormsProvider.java#L22