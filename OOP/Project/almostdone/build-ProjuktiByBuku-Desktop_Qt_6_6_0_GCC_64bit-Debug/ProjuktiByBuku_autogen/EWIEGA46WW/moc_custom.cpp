/****************************************************************************
** Meta object code from reading C++ file 'custom.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../ProjuktiByBuku/custom.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'custom.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASScustomENDCLASS_t {};
static constexpr auto qt_meta_stringdata_CLASScustomENDCLASS = QtMocHelpers::stringData(
    "custom",
    "on_save_button_clicked",
    "",
    "on_alarm_button_clicked",
    "read_pomo_time",
    "read_sbreak_time",
    "read_lbreak_time",
    "indexChanged",
    "index"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASScustomENDCLASS_t {
    uint offsetsAndSizes[18];
    char stringdata0[7];
    char stringdata1[23];
    char stringdata2[1];
    char stringdata3[24];
    char stringdata4[15];
    char stringdata5[17];
    char stringdata6[17];
    char stringdata7[13];
    char stringdata8[6];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASScustomENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASScustomENDCLASS_t qt_meta_stringdata_CLASScustomENDCLASS = {
    {
        QT_MOC_LITERAL(0, 6),  // "custom"
        QT_MOC_LITERAL(7, 22),  // "on_save_button_clicked"
        QT_MOC_LITERAL(30, 0),  // ""
        QT_MOC_LITERAL(31, 23),  // "on_alarm_button_clicked"
        QT_MOC_LITERAL(55, 14),  // "read_pomo_time"
        QT_MOC_LITERAL(70, 16),  // "read_sbreak_time"
        QT_MOC_LITERAL(87, 16),  // "read_lbreak_time"
        QT_MOC_LITERAL(104, 12),  // "indexChanged"
        QT_MOC_LITERAL(117, 5)   // "index"
    },
    "custom",
    "on_save_button_clicked",
    "",
    "on_alarm_button_clicked",
    "read_pomo_time",
    "read_sbreak_time",
    "read_lbreak_time",
    "indexChanged",
    "index"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASScustomENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   50,    2, 0x08,    1 /* Private */,
       3,    0,   51,    2, 0x08,    2 /* Private */,
       4,    0,   52,    2, 0x08,    3 /* Private */,
       5,    0,   53,    2, 0x08,    4 /* Private */,
       6,    0,   54,    2, 0x08,    5 /* Private */,
       7,    1,   55,    2, 0x08,    6 /* Private */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Int,
    QMetaType::Void, QMetaType::Int,    8,

       0        // eod
};

Q_CONSTINIT const QMetaObject custom::staticMetaObject = { {
    QMetaObject::SuperData::link<QDialog::staticMetaObject>(),
    qt_meta_stringdata_CLASScustomENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASScustomENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASScustomENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<custom, std::true_type>,
        // method 'on_save_button_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_alarm_button_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'read_pomo_time'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'read_sbreak_time'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'read_lbreak_time'
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'indexChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>
    >,
    nullptr
} };

void custom::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<custom *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->on_save_button_clicked(); break;
        case 1: _t->on_alarm_button_clicked(); break;
        case 2: { int _r = _t->read_pomo_time();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 3: { int _r = _t->read_sbreak_time();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 4: { int _r = _t->read_lbreak_time();
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 5: _t->indexChanged((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        default: ;
        }
    }
}

const QMetaObject *custom::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *custom::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASScustomENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QDialog::qt_metacast(_clname);
}

int custom::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 6;
    }
    return _id;
}
QT_WARNING_POP
