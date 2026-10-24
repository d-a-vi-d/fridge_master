Householdscreen überarbeiten

Seiteneffekt in build(). addPostFrameCallback mit select(...) ändert State mitten im Bauen. build() kann öfter laufen, als du denkst. Der Code prüft außerdem nur auf null. Ist selected gesetzt, aber der Haushalt nicht mehr in der Liste, zeigst du den HomeScreen mit leerem Inventar. Die saubere Richtung ist ein abgeleiteter Provider (“gewählter Haushalt, sonst der erste”), dann gibt es keinen null-Zustand. Das ist der beste Lernstoff hier, und wir machen ihn gemeinsam.

Appshell Fehleransicht. Sie hat kein “Erneut versuchen” und kein “Ausloggen”, und sie zeigt den rohen Fehlertext. Dazu kommt der Tippfehler 'Fehler ${...}' ohne Doppelpunkt. Bei Streams haben hasError und hasValue auch gleichzeitig true. Dann gewinnt dein Fehlerscreen, obwohl Daten da wären.

Deep Link: Dein Code löst den Magic Link ein, obwohl supabase_flutter das schon macht, und der zweite Versuch scheitert wahrscheinlich mit otp_expired.
Fehlerbehandlung: Der catch ist ein FragMamaPapa-Überbleibsel und wirft jeden Fehler außer 404 weiter, wo ihn niemand auffängt.
Seiteneffekt in build(): Die Haushaltsauswahl wird mitten im Bauen gesetzt, das kostet einen Spinner-Frame, und eine ungültige Auswahl fällt nicht auf.
Fehleransicht: Sie ist eine Sackgasse (kein Retry, kein Logout), zeigt rohen Fehlertext und hat einen Tippfehler.
Imports: main.dart und app_shell.dart importieren sich gegenseitig, und die Importstile sind gemischt.
HouseholdScreen als Startseite: Er nutzt ein Navigator.pop, obwohl die Shell ihn nicht per Push öffnet, das ist ungetestet.

wtf macht products und household products labels auf supabase???

alternative zu magic link, am besten google



## TODO

### Bugs
- [ ] Einräumen legt bei jedem Scan eine neue Zeile an, statt die Menge zu erhöhen. Vorschlag: gleicher Barcode + gleiches MHD → `quantity + 1`, sonst neue Zeile (wegen mehrerer Packungen mit unterschiedlichem MHD).
- [ ] Selbst eingegebener Produktname wird nicht in Supabase gespeichert. Ursache unklar, der echte Fehler steht im Konsolenlog (`debugPrint` in `scan_provider.dart`).

### AppShell und Haushalte
- [ ] Haushaltsauswahl nicht mehr in `build()` setzen (`addPostFrameCallback`). Stattdessen abgeleiteter Provider "gewählter Haushalt, sonst der erste". Dabei den Fall abdecken, dass der gewählte Haushalt nicht mehr existiert.
- [ ] Fehleransicht: "Erneut versuchen" und "Ausloggen" ergänzen, rohen Fehlertext durch eine verständliche Meldung ersetzen, Doppelpunkt nach "Fehler" ergänzen.
- [ ] `hasError` und `hasValue` können bei Streams gleichzeitig `true` sein. Entscheiden, was dann angezeigt wird (Fehler oder Daten).
- [ ] `households`-Stream liefert mit der Policy "findable by invite code" alle Haushalte, nicht nur die eigenen. Liste im Provider mit den eigenen Mitgliedschaften abgleichen.
- [ ] Entscheiden, wie der Beitritt per Code abgesichert wird: offene SELECT-Policy (Option A, Codes für alle Eingeloggten lesbar) oder kleine DB-Funktion (Option B, Codes geheim).
- [ ] `HouseholdScreen` überarbeiten (Layout, Wechsel/Erstellen/Beitreten übersichtlicher).

### Fehlerbehandlung
- [ ] `ErrorSnackbar`: `AuthException`- und `PostgrestException`-Zweige aktivieren (aktuell auskommentiert, Supabase-Fehler zeigen "unerwarteter Fehler"). Für Magic Link mindestens "Link abgelaufen" und 429 "Zu viele Versuche".

### Features
- [ ] Google-Login als Alternative zu Magic Link: OAuth-Client in der Google Cloud Console anlegen, Google-Provider in Supabase aktivieren (Authentication → Providers), Redirect-URLs für App und Web eintragen.
- [ ] Nach dem Einräumen "X hinzugefügt" mit Button "Ändern" (haushaltsspezifische Bezeichnung über `setHouseholdLabel`).
- [ ] MHD beim Einräumen eingeben (`stockIn` kann `expiryDate`, der Scan-Flow übergibt aktuell keins).
- [ ] Mitbewohner anzeigen. Braucht eine Hilfsfunktion `is_household_member`, weil eine Policy auf `household_members`, die sich selbst abfragt, endlos rekursiert.

### Aufräumen
- [ ] Auskommentierten Link-Handler aus `app_shell.dart` löschen.
- [ ] `app_links` aus `pubspec.yaml` entfernen (`supabase_flutter` bringt es selbst mit). Intent-Filter, `Info.plist` und Redirect-URL bleiben.
- [ ] Globale Variable `supabase` aus `main.dart` in eine eigene Datei auslagern. `main.dart` und die Provider/Services importieren sich sonst gegenseitig.
- [ ] Importstil vereinheitlichen (entweder `package:` oder relativ, nicht mischen).
- [ ] Ordner `linux/`, `macos/`, `windows/` löschen (enthalten noch `flutter_template`, werden nicht genutzt). Optional.

### Zu prüfen (Stand unklar)
- [ ] `Navigator.pop` im `HouseholdScreen`: Neuer Account ohne Haushalt, Haushalt erstellen. Die Shell zeigt den Screen dort direkt an, er wird nicht gepusht.
- [ ] Rückbau-SQL ausgeführt? (Funktionen `create_household` und `join_household` gelöscht, Policies neu angelegt.)
- [ ] `upsertProduct` bei bekanntem Produkt: Mein Verdacht (fehlende UPDATE-Policy, Fix `ignoreDuplicates: true`) ist ungeklärt. Dein Bug "Einräumen legt neue Zeile an" spricht eher dagegen, der zweite Scan lief ja durch.
- [ ] `SignInScreen`: Fehler beim Senden des Magic Links abfangen und anzeigen (bei 429 passiert sonst nichts Sichtbares). Prüfen, ob schon umgesetzt.
- [ ] Abgelaufenen oder schon benutzten Magic Link antippen: Was sieht der Nutzer?
- [ ] Netzwerkfehler im Web: Kommt `SocketException` an oder ein anderer Typ? (Vermutung, nicht belegt)

### Erledigt
- [x] Deep Link: eigener Handler entfernt, Magic-Link-Login funktioniert über `supabase_flutter` allein (ein Login getestet).
- [x] `catch` mit 404 im Handler: entfällt mit dem Handler.
- [x] `AppShell` ist ein `ConsumerWidget` ohne State.
- [x] Zirkelimport `app_shell.dart` ↔ `main.dart`: entfällt. Über Provider und Services bleibt er, siehe Aufräumen.