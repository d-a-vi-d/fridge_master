webtab name ist noch flutter-template

Householdscreen überarbeiten

einräumen added neues statt quantity erhöhen
selber produktname eingeben speichert nicht auf supabase xdd

Seiteneffekt in build(). addPostFrameCallback mit select(...) ändert State mitten im Bauen. build() kann öfter laufen, als du denkst. Der Code prüft außerdem nur auf null. Ist selected gesetzt, aber der Haushalt nicht mehr in der Liste, zeigst du den HomeScreen mit leerem Inventar. Die saubere Richtung ist ein abgeleiteter Provider (“gewählter Haushalt, sonst der erste”), dann gibt es keinen null-Zustand. Das ist der beste Lernstoff hier, und wir machen ihn gemeinsam.

Appshell Fehleransicht. Sie hat kein “Erneut versuchen” und kein “Ausloggen”, und sie zeigt den rohen Fehlertext. Dazu kommt der Tippfehler 'Fehler ${...}' ohne Doppelpunkt. Bei Streams haben hasError und hasValue auch gleichzeitig true. Dann gewinnt dein Fehlerscreen, obwohl Daten da wären.

Deep Link: Dein Code löst den Magic Link ein, obwohl supabase_flutter das schon macht, und der zweite Versuch scheitert wahrscheinlich mit otp_expired.
Fehlerbehandlung: Der catch ist ein FragMamaPapa-Überbleibsel und wirft jeden Fehler außer 404 weiter, wo ihn niemand auffängt.
Seiteneffekt in build(): Die Haushaltsauswahl wird mitten im Bauen gesetzt, das kostet einen Spinner-Frame, und eine ungültige Auswahl fällt nicht auf.
Fehleransicht: Sie ist eine Sackgasse (kein Retry, kein Logout), zeigt rohen Fehlertext und hat einen Tippfehler.
Imports: main.dart und app_shell.dart importieren sich gegenseitig, und die Importstile sind gemischt.
HouseholdScreen als Startseite: Er nutzt ein Navigator.pop, obwohl die Shell ihn nicht per Push öffnet, das ist ungetestet.