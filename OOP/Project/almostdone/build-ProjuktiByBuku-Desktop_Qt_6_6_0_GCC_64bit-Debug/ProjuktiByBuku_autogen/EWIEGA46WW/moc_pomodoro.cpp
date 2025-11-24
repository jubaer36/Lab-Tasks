/****************************************************************************
** Meta object code from reading C++ file 'pomodoro.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../ProjuktiByBuku/pomodoro.h"
#include <QtGui/qtextcursor.h>
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'pomodoro.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.6.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSpomodoroENDCLASS_t {};
static constexpr auto qt_meta_stringdata_CLASSpomodoroENDCLASS = QtMocHelpers::stringData(
    "pomodoro",
    "on_start_stop_button_clicked",
    "",
    "on_customize_button_clicked",
    "updateTimer",
    "read_pomo_time",
    "read_sbreak_time",
    "read_lbreak_time",
    "on_skip_button_clicked",
    "notification_sound",
    "on_lofi_button_clicked",
    "saveProgressToFile"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSpomodoroENDCLASS_t {
    uint offsetsAndSizes[24];
    char stringdata0[9];
    char stringdata1[29];
    char stringdata2[1];
    char stringdata3[28];
    char stringdata4[12];
    char stringdata5[15];
    char stringdata6[17];
    char stringdata7[17];
    char stringdata8[23];
    char stringdata9[19];
    char stringdata10[23];
    char stringdata11[19];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSpomodoroENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSpomodoroENDCLASS_t qt_meta_stringdata_CLASSpomodoroENDCLASS = {
    {
        QT_MOC_LITERAL(0, 8),  // "pomodoro"
        QT_MOC_LITERAL(9, 28),  // "on_start_stop_button_clicked"
        QT_MOC_LITERAL(38, 0),  // ""
        QT_MOC_LITERAL(39, 27),  // "on_customize_button_clicked"
        QT_MOC_LITERAL(67, 11),  // "updateTimer"
        QT_MOC_LITERAL(79, 14),  // "read_pomo_time"
        QT_MOC_LITERAL(94, 16),  // "read_sbreak_time"
        QT_MOC_LITERAL(111, 16),  // "read_lbreak_time"
        QT_MOC_LITERAL(128, 22),  // "on_skip_button_clicked"
        QT_MOC_LITERAL(151, 18),  // "notification_sound"
        QT_MOC_LITERAL(170, 22),  // "on_lofi_button_clicked"
        QT_MOC_LITERAL(193, 18)   // "saveProgressToFile"
    },
    "pomodoro",
    "on_start_stop_button_clicked",
    "",
    "on_customize_button_clicked",
    "updateTimer",
    "read_pomo_time",
    "read_sbreak_time",
    "read_lbreak_time",
    "on_skip_button_clicked",
    "notification_sound",
    "on_lofi_button_clicked",
    "saveProgressToFile"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSpomodoroENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   74,    2, 0x08,    1 /* Private */,
       3,    0,   75,    2, 0x08,    2 /* Private */,
       4,    0,   76,    2, 0x08,    3 /* Private */,
       5,    0,   77,    2, 0x08,    4 /* Private */,
       6,    0,   78,    2, 0x08,    5 /* Private */,
       7,    0,   79,    2, 0x08,    6 /* Private */,
       8,    0,   80,    2, 0x08,    7 /* Private */,
       9,    0,   81,    2, 0x08,    8 /* Private */,
      10,    0,   82,    2, 0x08,    9 /* Private */,
      11,    0,   83,    2, 0x08,   10 /* Private */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

Q_CONSTINIT const QMetaObject pomodoro::staticMetaObject = { {
    QMetaObject::SuperData::link<QDialog::staticMetaObject>(),
    qt_meta_stringdata_CLASSpomodoroENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSpomodoroENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSpomodoroENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<pomodoro, std::true_type>,
        // method 'on_start_stop_button_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_customize_button_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'updateTimer'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'read_pomo_time'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'read_sbreak_time'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'read_lbreak_time'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'on_skip_button_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'notification_sound'
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'on_lofi_button_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'saveProgressToFile'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void pomodoro::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<pomodoro *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->on_start_stop_button_clicked(); break;
        case 1: _t->on_customize_button_clicked(); break;
        case 2: _t->updateTimer(); break;
        case 3: { int _r = _t->read_pomo_time();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 4: { int _r = _t->read_sbreak_time();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 5: { int _r = _t->read_lbreak_time();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 6: _t->on_skip_button_clicked(); break;
        case 7: { QString _r = _t->notification_sound();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 8: _t->on_lofi_button_clicked(); break;
        case 9: _t->saveProgressToFile(); break;
        default: ;
        }
    }
}

const QMetaObject *pomodoro::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *pomodoro::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSpomodoroENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QDialog::qt_metacast(_clname);
}

int pomodoro::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 10;
    }
    return _id;
}
QT_WARNING_POP
