from PyInquirer import style_from_dict, Token

USER = 'user_1'
PASSWORD = 'password_1'
SERVER = 'localhost'
DATABASE_NAME = 'byte_bazaar'
DATABASE_URI = f'mysql://{USER}:{PASSWORD}@{SERVER}/{DATABASE_NAME}'
ECHO = False


def style():
    style = style_from_dict({
        Token.Separator: '#cc5454',
        Token.QuestionMark: '#7f7fff bold',
        Token.Selected: '#5F819D',
        Token.Pointer: '#5F819D bold',
        Token.Instruction: '',
        Token.Answer: '#5F819D bold',
        Token.Question: '',
    })
    return style


def logo():
    logo = '''
  *(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((( 
  *(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((( 
  *(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((( 
  *((((((((                            .,,.                           ((((((((( 
  *((((((((/                       ((,      /(/                      .((((((((( 
  *(((((((,                      ((. %%%#%%&( *(*                      (((((((( 
  *(((((/                       /(.  %&%&&&%   /(.                      ,(((((( 
  *((((                         /(,  %%%  &%%  /(.    .    .              /(((( 
  *((((((((* .(((((((((((((((((((((((((*..,((((((((((((((((((((((((/  ((((((((( 
  *((((((((* .(((((((((((((((((((((((((* .(((((((((((((((((((((((((/  ((((((((( 
  *((((((((* .(((((((((((((((((((((((((/ .(((((((((((((((((((((((((/  ((((((((( 
  *((((((((*  (((((((((((((((((((((((((/ .(((((((((((((((((((((((((*  ((((((((( 
  *((((((((/  /((((((((((((((((((((((((,  (((((((((((((((((((((((((  .((((((((( 
  *(((((((((    ((((((((((((((((((((((.    ((((((((((((((((((((((.   /((((((((( 
  *((((((((((                                                       ((((((((((( 
  *(((((((((((((,                                               ./((((((((((((( 
  *(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((( 
  *(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((( 
  *(((((,                              /((                               (((((( 
  *(((((*                              /((                              .(((((( 
  *((((((((((  (((((((((((((((((/ ,(((((((((((( ,(((((((((((((((((. ((((((((((( 
  *((((((((((  (((((((((((((((((/ ,(((((((((((( .(((((((((((((((((. ((((((((((( 
  *((((((((((. (((((((((((((((((( *(((((((((((( *(((((((((((((((((, ((((((((((( 
  *(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((( 
  *(((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((( 


    '''
    print(logo)
