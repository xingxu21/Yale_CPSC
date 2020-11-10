from components import Rotor, Reflector, Plugboard, ALPHABET, ROTOR_NOTCHES, ROTOR_WIRINGS
from machine import Enigma

import pytest

#test components
def test_Rotor_init():
	A = Rotor('I','a')
	assert A.rotor_num == 'I'
	assert A.wiring == ROTOR_WIRINGS['I']
	assert A.notch == ROTOR_NOTCHES['I']
	assert A.window == 'A'
	assert A.offset == 0
	assert A.next_rotor == None
	assert A.prev_rotor == None

	with pytest.raises(ValueError):
		Fail = Rotor("","")


def test_Rotor_repr():
	A = Rotor('I','a', 'II','III')
	assert A.__repr__() == 'Window: A'


def test_Rotor_step_no_second_rotor():
	A = Rotor('I','a')
	A_offset = A.offset

	A.step()

	assert A.offset == (A_offset+1)%26
	assert A.window == ALPHABET[(A_offset+1)%26]


def test_Rotor_step_with_second_rotor():
	B = Rotor('II','a')
	A = Rotor('I','Q',B)

	B_offset = B.offset
	A_offset = A.offset

	A.step()

	assert B.offset == (B_offset+1)%26
	assert B.window == ALPHABET[(B_offset+1)%26]
	assert A.offset == (A_offset+1)%26
	assert A.window == ALPHABET[(A_offset+1)%26]


def test_Rotor_doublestep():
	B = Rotor('II','e')
	A = Rotor('I','a',B)

	B_offset = B.offset
	A.step()

	assert B.offset == (B_offset+1)%26
	assert B.window == ALPHABET[(B_offset+1)%26]


def test_Rotor_encode_letter():
	A = Rotor('I','a')
	assert A.encode_letter('a')


def test_Rotor_encode_letters_forward_nothing():
	A = Rotor('I','a')
	ret = A.encode_letter('a')
	index = ALPHABET.index('a'.upper())

	output_letter = A.wiring['forward'][(index + A.offset)%26]
	output_index = (ALPHABET.index(output_letter) - A.offset)%26

	assert ret == output_index

def test_Rotor_encode_letters_forward_return_letter():
	A = Rotor('I','a')
	ret = A.encode_letter('a',return_letter=True)
	index = ALPHABET.index('a'.upper())
	output_letter = A.wiring['forward'][(index + A.offset)%26]
	output_index = (ALPHABET.index(output_letter) - A.offset)%26
	assert ret == ALPHABET[output_index]

	assert A.encode_letter('a', printit=True)


def test_Rotor_encode_letters_forward_next():
	C = Rotor('III','a')
	B = Rotor('II','a')
	A = Rotor('I','a')
	index = ALPHABET.index('a'.upper())

	A.next_rotor = B
	B.prev_rotor = A
	B.next_rotor = C 

	ret = B.encode_letter('a',forward=True)
	output_letter = B.wiring['forward'][(index + B.offset)%26]
	output_index = (ALPHABET.index(output_letter) - B.offset)%26
	assert ret == B.next_rotor.encode_letter(output_index, True)


def test_Rotor_encode_letters_backwards_nothing():
	A = Rotor('I','a')
	ret = A.encode_letter('a', False)
	index = ALPHABET.index('a'.upper())

	output_letter = A.wiring['backward'][(index + A.offset)%26]
	output_index = (ALPHABET.index(output_letter) - A.offset)%26

	assert ret == output_index


def test_Rotor_encode_letters_backwards_return_letter():
	A = Rotor('I','a')
	ret = A.encode_letter('a',False,return_letter=True)
	index = ALPHABET.index('a'.upper())
	output_letter = A.wiring['backward'][(index + A.offset)%26]
	output_index = (ALPHABET.index(output_letter) - A.offset)%26

	assert ret == ALPHABET[output_index]

	assert A.encode_letter('a',False, printit=True)


def test_Rotor_encode_letters_backwards_next():
	C = Rotor('III','a')
	B = Rotor('II','a')
	A = Rotor('I','a')
	index = ALPHABET.index('a'.upper())

	A.next_rotor = B
	B.prev_rotor = A
	B.next_rotor = C 

	ret = B.encode_letter('a',forward=False)
	output_letter = B.wiring['backward'][(index + B.offset)%26]
	output_index = (ALPHABET.index(output_letter) - B.offset)%26
	assert ret == B.prev_rotor.encode_letter(output_index, False)



def test_Rotor_change_setting():
	A = Rotor('I','a')
	A.change_setting('b')
	assert A.window == 'B'
	assert A.offset == 1


def test_Reflector_init():
	B = Reflector()
	assert B.wiring == {'A':'Y', 'B':'R', 'C':'U', 'D':'H', 'E':'Q', 'F':'S', 'G':'L', 'H':'D',
						'I':'P', 'J':'X', 'K':'N', 'L':'G', 'M':'O', 'N':'K', 'O':'M', 'P':'I',
						'Q':'E', 'R':'B', 'S':'F', 'T':'Z', 'U': 'C', 'V':'W', 'W':'V', 'X':'J',
						'Y':'A', 'Z':'T'
						}


def test_Reflector_repr():
	B = Reflector()
	assert B.__repr__() == ''


def test_Plugboard_init():
	C = Plugboard(['AB','CD'])
	assert C.swaps == {'A':'B', 'C':'D', 'B':'A','D':'C'}

def test_Plugboard_init_no_swaps():
	C = Plugboard(None) 
	assert C

def test_Plugboard_init_empty_swaps():
	C = Plugboard([]) 
	assert C

def test_Plugboard_repr():
	C = Plugboard(['AB','CD'])
	assert C.__repr__() == ''


def test_Plugboard_print_swaps():
	C = Plugboard(['AB','CD'])
	assert C.print_swaps() == None


def test_Plugboard_update_swaps_true():
	C = Plugboard(['AB','CD'])
	
	C.update_swaps(['EF','GH'], True)
	assert C.swaps == {'E':'F', 'G':'H', 'F':'E', 'H':'G'}


def test_Plugboard_update_swaps_false():
	C = Plugboard(['AB','CD'])

	C.update_swaps(['EF','GH'], False)
	assert C.swaps == {'A':'B', 'C':'D', 'B':'A','D':'C', 'E':'F', 'G':'H', 'F':'E', 'H':'G'}


def test_Plugboard_update_swaps_too_many():
	C = Plugboard(['AB','CD'])

	assert C.update_swaps(['EF','GH', 'IJ', 'KL', 'MN', 'OP', 'QR'], True) == None

def test_Plugboard_update_swaps_no_swaps():
	C = Plugboard(['AB','CD'])
	assert C.update_swaps([], True) == None

def test_Plugboard_update_swaps_not_list():
	C = Plugboard(['AB','CD'])
	assert C.update_swaps({'A':'F'}, True) == None


#test machine
def test_Enigma_init():
	enig = Enigma()
	assert enig.key == 'AAA'
	assert enig.rotor_order == ['I', 'II', 'III']

def test_Enigma_init_short_key():
	with pytest.raises(ValueError):
		enig = Enigma('AA')
		enig = Enigma('AAAAAA')


def test_Enigma_repr():
	enig = Enigma()
	ret = enig.__repr__()
	assert ret == 'Key: AAA'

	enig = Enigma()
	enig.set_rotor_position('ZAF',printIt=True)
	ret = enig.__repr__()
	assert ret == 'Key: ZAF'



def test_Enigma_encipher_ints():
	enig = Enigma()
	ret = enig.encipher('123')
	assert ret == 'Please provide a string containing only the characters a-zA-Z and spaces.'


def test_Enigma_encipher_message():
	enig = Enigma()
	ret = enig.encipher('where in the world is carmen sandiago')
	assert ret == 'KPCURLRRTCCHIYPKUYPVAPZPFGBVCPG'

def test_Enigma_decipher_message():
	enig = Enigma()
	ret = enig.decipher('KPCURLRRTCCHIYPKUYPVAPZPFGBVCPG')
	assert ret == 'WHEREINTHEWORLDISCARMENSANDIAGO'

def test_Enigma_encode_decode_letter_int():
	enig = Enigma()
	ret = enig.encode_decode_letter('1')
	assert ret == 'Please provide a letter in a-zA-Z.'

def test_Enigma_encode_decode_letter_inornot_plug():
	enig = Enigma(swaps=[('A','S')])
	ret = enig.encode_decode_letter('A')
	assert ret == 'J'

	enig = Enigma()
	ret = enig.encode_decode_letter('H')
	assert ret == 'I'


def test_Enigma_encode_decode_letter_final_in_Plug():
	enig = Enigma(swaps = [('I','N')])
	ret = enig.encode_decode_letter('H')
	assert ret == 'N'


def test_Enigma_rotor_pos_not_str_or_not_len3():
	enig = Enigma()
	ret = enig.set_rotor_position(123)
	assert ret == None

	enig = Enigma()
	ret = enig.set_rotor_position('A')
	assert ret == None

def test_Enigma_rotor_pos_ZAF_print():
	enig = Enigma()
	enig.set_rotor_position('ZAF',printIt=True)
	assert enig.key == 'ZAF'
	assert enig.l_rotor.window == 'Z'
	assert enig.m_rotor.window == 'A'
	assert enig.r_rotor.window == 'F'

def test_Enigma_rotor_pos_ZAF_no_print():
	enig = Enigma()
	enig.set_rotor_position('ZAF',printIt=False)
	assert enig.key == 'ZAF'
	assert enig.l_rotor.window == 'Z'
	assert enig.m_rotor.window == 'A'
	assert enig.r_rotor.window == 'F'


def test_Enigma_set_rotor_order_scramble1():
	enig = Enigma(key ='ZAF')
	enig.set_rotor_order(['III', 'I', 'II'])

	assert enig.l_rotor.wiring == {'forward': 'BDFHJLCPRTXVZNYEIWGAKMUSQO', 'backward': 'TAGBPCSDQEUFVNZHYIXJWLRKOM'}
	assert enig.m_rotor.wiring == {'forward': 'EKMFLGDQVZNTOWYHXUSPAIBRCJ', 'backward': 'UWYGADFPVZBECKMTHXSLRINQOJ'}
	assert enig.r_rotor.wiring == {'forward': 'AJDKSIRUXBLHWTMCQGZNPYFVOE', 'backward': 'AJPCZWRLFBDKOTYUQGENHXMIVS'}

	assert enig.l_rotor.window == 'Z'
	assert enig.m_rotor.window == 'A'
	assert enig.r_rotor.window == 'F'

def test_Enigma_set_rotor_order_scramble2():
	enig = Enigma(key ='ZAF')
	enig.set_rotor_order(['II', 'III', 'I'])

	assert enig.l_rotor.wiring == {'forward': 'AJDKSIRUXBLHWTMCQGZNPYFVOE', 'backward': 'AJPCZWRLFBDKOTYUQGENHXMIVS'}
	assert enig.m_rotor.wiring == {'forward': 'BDFHJLCPRTXVZNYEIWGAKMUSQO', 'backward': 'TAGBPCSDQEUFVNZHYIXJWLRKOM'}
	assert enig.r_rotor.wiring == {'forward': 'EKMFLGDQVZNTOWYHXUSPAIBRCJ', 'backward': 'UWYGADFPVZBECKMTHXSLRINQOJ'}

	assert enig.l_rotor.window == 'Z'
	assert enig.m_rotor.window == 'A'
	assert enig.r_rotor.window == 'F'


def test_Enigma_set_plugs_none():
	enig = Enigma()
	with pytest.raises(TypeError):
		ret = enig.set_plugs()


def test_Enigma_set_plugs():
	enig = Enigma()
	ret = enig.set_plugs(['EF','GH'], True)
	assert ret == None


def test_constants_wirings():
	assert ROTOR_WIRINGS == {
	'I':{'forward':'EKMFLGDQVZNTOWYHXUSPAIBRCJ',
		'backward':'UWYGADFPVZBECKMTHXSLRINQOJ'},
	'II':{'forward':'AJDKSIRUXBLHWTMCQGZNPYFVOE',
		'backward':'AJPCZWRLFBDKOTYUQGENHXMIVS'},
	'III':{'forward':'BDFHJLCPRTXVZNYEIWGAKMUSQO',
		'backward':'TAGBPCSDQEUFVNZHYIXJWLRKOM'},
	'V':{'forward':'VZBRGITYUPSDNHLXAWMJQOFECK',
		'backward':'QCYLXWENFTZOSMVJUDKGIARPHB'}
	}

	enig = Enigma('ZAP')
	encoding = enig.encipher('VNLAZTKMCJQCNTTZMOXQ')

	assert ROTOR_WIRINGS == {
	'I':{'forward':'EKMFLGDQVZNTOWYHXUSPAIBRCJ',
		'backward':'UWYGADFPVZBECKMTHXSLRINQOJ'},
	'II':{'forward':'AJDKSIRUXBLHWTMCQGZNPYFVOE',
		'backward':'AJPCZWRLFBDKOTYUQGENHXMIVS'},
	'III':{'forward':'BDFHJLCPRTXVZNYEIWGAKMUSQO',
		'backward':'TAGBPCSDQEUFVNZHYIXJWLRKOM'},
	'V':{'forward':'VZBRGITYUPSDNHLXAWMJQOFECK',
		'backward':'QCYLXWENFTZOSMVJUDKGIARPHB'}
	}

	decipher = enig.decipher(encoding)

	assert ROTOR_WIRINGS == {
	'I':{'forward':'EKMFLGDQVZNTOWYHXUSPAIBRCJ',
		'backward':'UWYGADFPVZBECKMTHXSLRINQOJ'},
	'II':{'forward':'AJDKSIRUXBLHWTMCQGZNPYFVOE',
		'backward':'AJPCZWRLFBDKOTYUQGENHXMIVS'},
	'III':{'forward':'BDFHJLCPRTXVZNYEIWGAKMUSQO',
		'backward':'TAGBPCSDQEUFVNZHYIXJWLRKOM'},
	'V':{'forward':'VZBRGITYUPSDNHLXAWMJQOFECK',
		'backward':'QCYLXWENFTZOSMVJUDKGIARPHB'}
	}




def test_constants_Notches():
	assert ROTOR_NOTCHES == {
	'I':'Q', # Next rotor steps when I moves from Q -> R
	'II':'E', # Next rotor steps when II moves from E -> F
	'III':'V', # Next rotor steps when III moves from V -> W
	'V':'Z' # Next rotor steps when V moves from Z -> A
	}

	enig = Enigma('ZAP')
	encoding = enig.encipher('VNLAZTKMCJQCNTTZMOXQ')

	assert ROTOR_NOTCHES == {
	'I':'Q', # Next rotor steps when I moves from Q -> R
	'II':'E', # Next rotor steps when II moves from E -> F
	'III':'V', # Next rotor steps when III moves from V -> W
	'V':'Z' # Next rotor steps when V moves from Z -> A
	}

	decipher = enig.decipher(encoding)

	assert ROTOR_NOTCHES == {
	'I':'Q', # Next rotor steps when I moves from Q -> R
	'II':'E', # Next rotor steps when II moves from E -> F
	'III':'V', # Next rotor steps when III moves from V -> W
	'V':'Z' # Next rotor steps when V moves from Z -> A
	}


def test_constants_Alphabet():
	assert ALPHABET == 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

	enig = Enigma('ZAP')
	encoding = enig.encipher('VNLAZTKMCJQCNTTZMOXQ')

	assert ALPHABET == 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

	decipher = enig.decipher(encoding)

	assert ALPHABET == 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'


def test_stress():
	enig = Enigma('ZAP')
	encoding = enig.encipher('VNLAZTKMCJQCNTTZMOXQ'*10000)

	assert enig.l_rotor.window == 'V'
	assert enig.r_rotor.window == 'X'
	assert enig.m_rotor.window == 'T'

	enig = Enigma('ZAP')
	decipher = enig.decipher(encoding)

	assert decipher == 'VNLAZTKMCJQCNTTZMOXQ'*10000
	assert enig.l_rotor.window == 'V'
	assert enig.r_rotor.window == 'X'
	assert enig.m_rotor.window == 'T'


def test_stress2():
	enig = Enigma(key = "ZQE", rotor_order = ['V','I','II'], swaps=['AB','PO','ES'])
	encoding = enig.encipher('VNLAZTKMCJQCNTTZMOXQ'*10000)

	assert enig.l_rotor.window == 'V'
	assert enig.r_rotor.window == 'M'
	assert enig.m_rotor.window == 'I'

	enig = Enigma(key = "ZQE", rotor_order = ['V','I','II'], swaps=['AB','PO','ES'])
	decipher = enig.decipher(encoding)

	assert decipher == 'VNLAZTKMCJQCNTTZMOXQ'*10000
	assert enig.l_rotor.window == 'V'
	assert enig.r_rotor.window == 'M'
	assert enig.m_rotor.window == 'I'


def test_check_rotors():
	enig = Enigma('ZAP')

	l_rotor = enig.l_rotor
	m_rotor = enig.m_rotor
	r_rotor = enig.r_rotor

	encoding = enig.encipher('VNLAZTKMCJQCNTTZMOXQ')

	assert l_rotor.wiring == enig.l_rotor.wiring
	assert m_rotor.wiring == enig.m_rotor.wiring
	assert r_rotor.wiring == enig.r_rotor.wiring


def test_double_decipher():
	enig = Enigma('ZAP')
	encoding = enig.encipher('VNLAZTKMCJQCNTTZMOXQ')
	decipher = enig.decipher(encoding)
	decipher2 = enig.decipher(encoding)

	assert decipher == 'TCXTTJYXJBSQMJZGQACG'
	assert decipher2 == 'VOGVFJIRTYWKMXYHDXUN'

	enig = Enigma('ZAP')
	assert enig.decipher(encoding) == 'VNLAZTKMCJQCNTTZMOXQ'
	assert enig.encipher(decipher) == encoding
	assert enig.encipher(decipher2) == encoding


	enig = Enigma()
	encoding = enig.encipher('VNLAZTKMCJQCNTTZMOXQ')
	decipher = enig.decipher(encoding)
	decipher2 = enig.decipher(encoding)

	assert decipher == 'PRMRMJXFVLKDSJCCJUIF'
	assert decipher2 == 'TJJXBBNBMQWRXQSZFMRU'

	enig = Enigma()
	assert enig.decipher(encoding) == 'VNLAZTKMCJQCNTTZMOXQ'
	assert enig.encipher(decipher) == encoding
	assert enig.encipher(decipher2) == encoding


def test_double_decipher2():
	enig = Enigma('ZAP')
	encoding = enig.encipher('VNLAZTKMCJQCN TTZMOXQ')
	encoding2 = enig.encipher('SHTMVEUVNYPL SGYBXMWJ')

	enig = Enigma('ZAP')
	assert enig.decipher(encoding) == 'VNLAZTKMCJQCNTTZMOXQ'
	assert enig.decipher(encoding2) == 'SHTMVEUVNYPLSGYBXMWJ'








