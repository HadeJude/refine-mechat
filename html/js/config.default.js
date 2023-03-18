window.CONFIG = {
  defaultTemplateId: 'default',
  defaultAltTemplateId: 'defaultAlt', 
  templates: {
    'default': '<div class="chat-message"><div class="chat-message-body"><strong>{0}:</strong> {1}</div></div>',
    'defaultAlt': '{0}',
    'print': '<pre>{0}</pre>',
    'example:important': '<h1>^2{0}</h1>'
  },
  fadeTimeout: 4000,
  suggestionLimit: 6,
  style: {
    background: 'transparent',
    width: '17.89%',
    height: '22%',
  }
};