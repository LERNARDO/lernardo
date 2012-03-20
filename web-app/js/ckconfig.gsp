<%@ page contentType="text/javascript"%>

CKEDITOR.editorConfig = function( config ) 
{
  // ckeditor SCAYT: http://docs.cksource.com/CKEditor_3.x/Howto/Enabling_SCAYT
  config.scayt_autoStartup = true;
  // SCAYT language: http://docs.cksource.com/CKEditor_3.x/Howto/SCAYT_Language
  if (${grailsApplication.config.customer == "noe"})
    config.scayt_sLang = 'de_DE';
  else if (${grailsApplication.config.customer == "sueninos"})
    config.scayt_sLang = 'es_ES';
}; 