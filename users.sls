{% set users = {
  'rohit': {
    'state': 'present',
    'fullname': 'rohit'
  },
  'abhishek': {
    'state': 'present',
    'fullname': 'abhishek'
  },
  'nitin': {
    'state': 'present',
    'fullname': 'nitin'
  }
} %}
 
{% for name, user in users.items() %}
{{ name }}:
  {% set shell = user.shell | default('/bin/bash') %}
  {% set groups = user.groups | default(['sudo', 'adm']) %}
  user.{{ user.state }}:
    - fullname: {{ user.fullname }}
    - home: /home/{{ name }}
    - shell: {{ shell }}
    - groups:
    {% for group in groups %}
      - {{ group }}
    {% endfor %}
  {% if user.state == 'present' %}
ssh_key_{{ name }}:
  ssh_auth:
    - present
    - user: {{ name }}
    - source: salt://pubkeys/gaurav_rajput.pub
    - require:
      - {{ name }}
  {% endif %}
{% endfor %}
