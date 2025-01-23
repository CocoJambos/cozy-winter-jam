## Wersja Godota

Godot 4.4-beta-1 w standardowej wersji, bez mono.

[- Windows](https://github.com/godotengine/godot-builds/releases/download/4.4-beta1/Godot_v4.4-beta1_win64.exe.zip)

[- Linux](https://github.com/godotengine/godot-builds/releases/download/4.4-beta1/Godot_v4.4-beta1_linux.x86_64.zip)

[- MacOS](https://github.com/godotengine/godot-builds/releases/download/4.4-beta1/Godot_v4.4-beta1_macos.universal.zip)

[- Export Templates](https://github.com/godotengine/godot-builds/releases/download/4.4-beta1/Godot_v4.4-beta1_export_templates.tpz)

## Jak odpalic projekt?

1. Pobieramy Godota z linkow podanych powyzej.
2. Wypakujemy Godota do jakiegos katalogu.
3. Pobieramy projekt za pomoca gita.
4. Otwieramy plik .exe z Godotem
5. Importujemy projekt wskazujac na katalog gdzie pobralismy pliki z gita.
6. Klikamy Edit i powinno wszystko smigac.

**Dodatkowe kroki**:
Mozecie rowniez pobrac pliki do eksportu projektu na WEB'a. Jest to dosyc proste. Wchodzicie do zakladki Export z menu co sie znajduje na pasku od okna. Powinno otworzyc sie okno i w lewym, gornym rogu jest opcja "Presets Add", klikacie w nia. Wybieracie WEB. Na dole okna wyswietli sie error, ze nie posiadacie tzw. export templates. Klikacie w manage export templates (nie pamietam jak dokladnie sie to nazywalo), otworzy sie wam okno i klikacie w przycisk install wybierajac pobrane export-templates, ktore sa podane powyzej.

## Zasady nazywania pliki i gdzie je umieszczac.

### Nomenklatura plikow:

Zasada jest prosta, wszystkie pliki nazywamy za pomoca snake_case'a. Czyli player_movement.gd player_object.tscn.

### Nomenklatura obiektow na scenie:

Przy obiektach uzywamy CamelCase oraz powinnismy sie starac nazywac dany obiekt z jego przeznaczeniem, zeby pozniej nie bylo problemow. 

Np.

PlayerLook - obiekt/galaz odpowiedzialna za wyglad gracza.

ConnectButton - przycisk UI, ktory jest odpowiedzialny za inicjalizacje laczenia sie z serwerem.

Obiekty, tzw. Node'y posiadaja rowniez ikonografie. Czasami one sa nie czytelne, radze uwazac.

### Struktura katalogow

Do katalogu glownego starajcie sie nic nie dodawac. Jesli potrzebujecie lepszej organizacji plikow, to dodajcie nowy katalog.

1. addons - pluginy/zew. tresc pobrana z zewnatrz, czyli jakies biblioteki, assety itd.
2. autoloads - sceny, ktore sie automatycznie laduja z uruchomieniem gry.
3. resources - wszystkie assety, ktore sa zapisywane w systemie plikow. Najczesciej laduja tam pliki godotowe.
4. scenes - sceny zwiazane z gra. Cos ala prefaby z Unity.
5. scripts - kod.
6. static_files - pliki z teksturami, blendera, modele 3D, muzyka itd.

### Zapisywanie plikow od Godota

Wszystkie pliki zwiazane z Godotem nie wlaczajac w to scen oraz skryptow, laduja do katalogu "resources". Zapisujemy w formatach .tscn - sceny, .tres - wszelakie obiekty godotowe co mozna zapisac na dysku, .gd - skrypty.
