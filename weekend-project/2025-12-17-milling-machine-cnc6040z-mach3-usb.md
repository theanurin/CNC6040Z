# CNC6040Z під керуванням YOOCNC M3-USB-JB4 V04

## Налаштування Mach3

В моєму випадку я використав Oracle VirtualBox для створення віртуальної машини з Windows XP 32-bit, бо саме таку операційну систему очікує програма Mach3.

### Налаштування Windows XP

- [ ] Вимкнути Screen Saver
- [ ] Вимкнути Power Off/Sleep

Заборонити всі сервіси (та вимкнути автозапуск) які можуть забирати процесорний час у Mach3.
Залишити мінімально необхідний набір:

- [ ] `TBD`
- [ ] `TBD`
- [ ] `TBD`

### Інсталяція Syncthing

- Качаємо, останню працюючу на Windows XP, версію `syncthing-windows-386-v1.0.1.zip`
- Розпаковуємо в `C:\Program Files\Syncthing\`
- Налаштовуємо автозапуск
    - Win + R, `regedit`, Enter
    - Створюємо рядковий параметер в `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run`: `"C:\Program Files\Syncthing\syncthing.exe" --no-console --no-browser`

### Інсталяція Mach3

- Завантажуємо з сайту офіційного сайту інсталятор [Mach3Version3.043.066.exe](https://www.machsupport.com/downloads-updates/mach3-downloads/)
- Достаємо файл ліцензії `Mach1Lic.dat` з бекапу
- Достаємо плагін `PlugIns/NcUsbPod.dll` з бекапу

Наступні дії виконуємо БЕЗ підключення контролера

- Виконуємо інсталятор `Mach3Version3.043.066.exe`
  - ✅ Директорія призначення `C:\Mach3`
  - На формі вибору компонентів `Select Packages`
    - ❌ НЕ інсталюємо Parallel Port Drivers
    - ❌ НЕ інсталюємо Wizards
    - ❌ НЕ інсталюємо LazyCams
    - ❌ НЕ інсталюємо Screen sets -> Mach3Turn
    - ❌ НЕ інсталюємо Screen sets -> Mach3 Plasma
  - ❌ НЕ створюємо профайлів
- Копіюємо ліцензію `Mach1Lic.dat` в `C:\Mach3\`
- Копіюємо плагін `NcUsbPod.dll` (v2.3.8.7) в `C:\Mach3\PlugIns\`
- Бекапимо оригінальний UI дизайн `C:\Mach3\1024.set` -> `C:\Mach3\default.set`
- Копіюємо CNC6040Z дизайн `1024.set`, `1024.lset`, `Bitmaps` в `C:\Mach3\`

### Налаштування програми

Під час першого завантаження з'явиться вікно `Motion Control Hardware PlugIn sensed!!`

- [x] NcUsbPod-XHC-Mach3-USB-Motion-Card
- [x] Dont ask me this again

Після завантаження

- Config -> Select Native Units
  - ✅ MM's
- Config -> Ports and Pins
  - Tab: Port Setup and Axis Selection
    - ❌ Port #1
    - ❌ Port #2
    - Kernel Speed
      - ✅ 25000hz
  - Tab: Motor Outputs
    - X Axis
      - Enabled: ✅
      - Step Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir LowActive: ✅
      - Step LowActive: ✅
      - Step Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
    - Y Axis
      - Enabled: ✅
      - Step Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir LowActive: ❌
      - Step LowActive: ✅
      - Step Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
    - Z Axis
      - Enabled: ✅
      - Step Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir LowActive: ❌
      - Step LowActive: ✅
      - Step Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
    - A Axis
      - Enabled: ✅
      - Step Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir LowActive: ❌
      - Step LowActive: ✅
      - Step Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
    - B Axis
      - Enabled: ❌
      - Step Pin#: -1
      - Dir Pin#: -1
      - Dir LowActive: ❌
      - Step LowActive: ❌
      - Step Port: -1
      - Dir Port: -1
    - C Axis
      - Enabled: ❌
      - Step Pin#: -1
      - Dir Pin#: -1
      - Dir LowActive: ❌
      - Step LowActive: ❌
      - Step Port: -1
      - Dir Port: -1
    - Spindle
      - Enabled: ✅
      - Step Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Pin#: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir LowActive: ❌
      - Step LowActive: ❌
      - Step Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
      - Dir Port: -1 (not used by NcUsbPod plugin, so set explicitly to -1)
  - Tab: Input Signals
    - Make For All Rows
      - Enabled: ❌
      - Port #: -1
      - Pin Number: -1
      - Active Low: ❌
      - Emulated: ❌
      - HotKey: 0
    - Probe
      - Enabled: ✅
      - Port #: -1
      - Pin Number: 4
      - Active Low: ✅
      - Emulated: ❌
      - HotKey: 0
    - EStop
      - Enabled: ✅
      - Port #: -1
      - Pin Number: 3
      - Active Low: ✅
      - Emulated: ❌
      - HotKey: 0
  - Tab: Output Signals
    - Make For All Rows
      - Enabled: ❌
      - Port #: -1
      - Pin Number: -1
      - Active Low: ❌
    - Output #1
      - Enabled: ✅
      - Port #: 1
      - Pin Number: 0
      - Active Low: ✅
  - Tab: Encoder/MPG's
    - Make For All Rows
      - Enabled: ❌
  - Tab: Spindle Setup
    - Relay Control
      - Disable Spindle Relays: ❌
      - Clockwise (M3) Output #: 1
      - CCW (M4) Output #: 1
    - Motor Control
      - Use Spindle Motor Output: ✅
      - PWM Control: ✅
      - Step/Dir Motor: ❌
      - PWMBase Freq: 4166
      - Minimum PWM: 1%
    - Flood Mist Control
      - Disable Flood/Mist relays: ✅
      - Mist (M7) Output #: 4, Delay: 0
      - Flood (M8) Output #: 3, Delay: 0
    - General Parameters
      - CW Delay Spin UP: 10 (Seconds)
      - CCW Delay Spin UP: 10 (Seconds)
      - CW Delay Spin DOWN: 10 (Seconds)
      - CCW Delay Spin DOWN: 10 (Seconds)
      - Immediate Relay off before delay: ✅
- Config -> Motor Turning
  - X Axis
    - Step per: 320
    - Velocity (In's or mm's per min): 900
    - Acceleration (in's or mm's/sec/sec): 80
    - Step Pulse (1-5 us): 0
    - Dir Pulse (0-5): 0
  - Y Axis
    - Step per: 320
    - Velocity (In's or mm's per min): 900
    - Acceleration (in's or mm's/sec/sec): 80
    - Step Pulse (1-5 us): 0
    - Dir Pulse (0-5): 0
  - Z Axis
    - Step per: 320
    - Velocity (In's or mm's per min): 450
    - Acceleration (in's or mm's/sec/sec): 80
    - Step Pulse (1-5 us): 0
    - Dir Pulse (0-5): 0
  - A Axis
    - Step per: 13.33333
    - Velocity (In's or mm's per min): 120
    - Acceleration (in's or mm's/sec/sec): 4
    - Step Pulse (1-5 us): 0
    - Dir Pulse (0-5): 0
  - B Axis - disabled(grey)
  - C Axis - disabled(grey)
  - Spindle
    - Step per: 1
    - Velocity (In's or mm's per min): 0
    - Acceleration (in's or mm's/sec/sec): 0
    - Step Pulse (1-5 us): 0
    - Dir Pulse (0-5): 0
- Config -> Spindle Pulleys...
  - Current Pulley: Pulley Number 1
  - Min Speed: 1200
  - Max Speed: 24000
  - Ratio: 1

Для налаштування Auto Tool Zero

- в XML файлі профілю `C:\Mach3\CNC6040Z-YOOCNC-USB-JB4.xml` встановлюємо значення висоти пробника `<OEMDRO1>19.2</OEMDRO1>` (19.2mm в мойому випадку)
- Редагуємо скрипт на кнопці `Auto Tool Zero`
  ```text
  TBD
  ```

## Налаштування Spindle/VFD

## Контролер YOOCNC M3-USB-JB4 V04

- Q3
    - маркування 5630
    - корпус SOT-23
    - типове підключення як NPN транзистор

```text
NODE_A:
  Оптрон
  Q3 pin 1

NODE_B:
  Q3 pin 2
  GND

NODE_C:
  Q3 pin 3
  Q2 pin 1
  Q1 pin 1
  R10 (10k)

NODE_D:
  L31
  Q1 pin 2
  R10 (10k)

NODE_E:
  L31
  V+ (опорна напруга)

NODE_F:
  Q2 pin 2
  GND

NODE_G:
  Q2 pin 3
  R18 240

NODE_H:
  Q3 pin 3
  R17 240

NODE_I:
  R18 240
  R17 240
  E20 47mF pin+
  R33 390 -> L32 -> OUT 0-10V
```

### 2025-12-19 Ремонт PWR -> DC 0-10V частини

#### Вихідний каскад

Стоїть Q1 (маркування 618).

По схемі підключення є PNP транзистором:

- На емітер подається опорна напруга
- На базу, через резистор R10 10-кОм, подається опорна напруга. Що відповідає вимкненому стану, так як емітерний перехід вважається закритим. Тобто вихідний конденсатор не заряджається.
- На колекторі, через R17 240-Ом, висить електролітичний конденсатор E12 47mF

В свою чергу Q3 прибиває напругу до землі, під час PWR модуляції, тим сам при-відкриває Q1 що дозволяє заряджати конденсатор E12

Проблема: При подачі опорного живлення оригінальний транзистор пропускає струм і конденсатор E12 заряджається (без сигналу дозволу). Таким чином на виході завжди 10V (опорна напруга)

Замінено на транзистор 2F. Після чого напруга перестала рости на подачі живлення та очікувано піднімається коли з'являється ШИМ (вмикаєш шпиндель).

## References

- https://www.cnczone.com/forums/news-announcements/319612-cnc-post2266193.html#post2266193
- https://www.youtube.com/watch?v=I7MZHrCX68Q
- [Video Instruction](https://www.youtube.com/watch?v=lncconN83G4)
- [Configuration sample by Karlosak](https://en.industryarena.com/forum/showthread.php?t=351996&p=2289900#post2289900)

## Spindle GDZ-80-1.5 Ø80X188 (1500W, 220V, 5А, ER11)

Шпиндель з водяним охолодженням.

Має три підшипники:

- Верхній (задній): Одиночний радіально упорний підшипник H7002C 2RZ/P4 HRB-HZ
- Нижній (передній): Піднана пара H7002C-2RZ/P4 DBA
  - DBA — коли потрібна жорсткість і робота в обох напрямках (як у шпинделі CNC6040Z)
  - DTA ставлять там, де осьове навантаження велике і стабільне в ОДНОМУ напрямку
