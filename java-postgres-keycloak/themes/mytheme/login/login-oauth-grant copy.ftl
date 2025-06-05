
<h1>aaaa</h1>

https://github.com/keycloak/keycloak/blob/main/services/src/main/java/org/keycloak/forms/login/freemarker/model/OAuthGrantBean.java#L30 <br />

https://github.com/keycloak/keycloak/blob/main/services/src/main/java/org/keycloak/forms/login/freemarker/model/ClientBean.java
<h2>client.attributes</h2>
<#if client.attributes??>
  <ul>
    <#list client.attributes?keys as key>
      <li>${key} : ${client.attributes[key]}</li>
    </#list>
  </ul>
<#else>
  <p>attributesはありません</p>
</#if>

<h2>list login</h2>
<#list login as key, item>
    <li>${key}</li>
</#list>
${login.getClass()}
<h2>list login.username</h2>
<#if login.getUsername()?? >
not null
<#else>
is null
</#if>


<h2>list client</h2>
<#list client as key, item>
    <li>${key}</li>
</#list>

<h2>client.clientId</h2>
${client.clientId}

<h2>client.name</h2>
${client.name}


<h2>client.getClass</h2>
${client.getClass()}

<h2>list client.attributes</h2>
<#list client.attributes as key,item >
    <li>${key}</li>
</#list>

<h2>list auth</h2>
<#list auth as key,item >
    <li>${key}</li>
</#list>
<#if auth.showUsername()??>
    getShowUsername() : ${ auth.showUsername()?then('Y','N') }はありまーす
<#else>
  <p>attributesはありません</p>
</#if>

<h2>auth.attributes</h2>
<#if auth.attributes??>
  <ul>
    <#list auth.attributes?keys as key>
      <li>${key} : ${auth.attributes[key]}</li>
    </#list>
  </ul>
<#else>
  <p>attributesはありません</p>
</#if>

<h2>social.attributes</h2>
<#if social.attributes??>
  <ul>
    <#list social.attributes?keys as key>
      <li>${key} : ${social.attributes[key]}</li>
    </#list>
  </ul>
<#else>
  <p>attributesはありません</p>
</#if>


<#function stringify obj>
    <#if !obj??>
        <#return 'undefined'>
    </#if>
    <#if obj?is_date>
        <#return '"' + obj?string("yyyy-MM-dd HH:mm:ss") + '"'>
    </#if>
    <#if obj?is_boolean || obj?is_number>
        <#return obj?string>
    </#if>
    <#if obj?is_enumerable>
        <#local str = '['>
        <#list obj as x>
            <#local str = str + stringify(x)>
            <#if x_has_next>
                <#local str = str + ','>
            </#if>
        </#list>
        <#return str + ']'>
    </#if>
    <#if obj?is_string>
        <#return '"' + obj?js_string + '"'>
    </#if>
    <#if obj?is_hash || obj?is_hash_ex>
        <#local str = '{'>
        <#local arr = [] >
        <#local keys = obj?keys>
        <#list keys as x>
            <#if x!='class' && obj[x]??>
                <#local arr = arr + [x]>
            </#if>
        </#list>
        <#list arr as x>
            <#local str = str + '"' + x + '" :' + stringify(obj[x])>
            <#if x_has_next>
                <#local str = str + ','>
            </#if>
        </#list>
        <#return str + '}'>
    </#if>
    <#return ''>
    <#if obj?is_string>
        <#return '"' + obj?js_string + '"'>
    </#if>
</#function>


<h2>stringify</h2>
${stringify(.data_model)}

