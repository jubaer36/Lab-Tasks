/****************************************************************************
** Meta object code from reading C++ file 'taskmanager.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../ProjuktiByBuku/taskmanager.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'taskmanager.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_CLASSTaskManagerENDCLASS_t {};
static constexpr auto qt_meta_stringdata_CLASSTaskManagerENDCLASS = QtMocHelpers::stringData(
    "TaskManager",
    "on_addPushButton_clicked",
    "",
    "on_removePushButton_clicked",
    "on_calendarWidget_selectionChanged",
    "on_routinePushButton_clicked",
    "checked",
    "loadItemsFromFile",
    "date1",
    "saveItemsToFile",
    "itemToAdd",
    "on_pushSaveAsRoutineButton_clicked"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSTaskManagerENDCLASS_t {
    uint offsetsAndSizes[24];
    char stringdata0[12];
    char stringdata1[25];
    char stringdata2[1];
    char stringdata3[28];
    char stringdata4[35];
    char stringdata5[29];
    char stringdata6[8];
    char stringdata7[18];
    char stringdata8[6];
    char stringdata9[16];
    char stringdata10[10];
    char stringdata11[35];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSTaskManagerENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSTaskManagerENDCLASS_t qt_meta_stringdata_CLASSTaskManagerENDCLASS = {
    {
        QT_MOC_LITERAL(0, 11),  // "TaskManager"
        QT_MOC_LITERAL(12, 24),  // "on_addPushButton_clicked"
        QT_MOC_LITERAL(37, 0),  // ""
        QT_MOC_LITERAL(38, 27),  // "on_removePushButton_clicked"
        QT_MOC_LITERAL(66, 34),  // "on_calendarWidget_selectionCh..."
        QT_MOC_LITERAL(101, 28),  // "on_routinePushButton_clicked"
        QT_MOC_LITERAL(130, 7),  // "checked"
        QT_MOC_LITERAL(138, 17),  // "loadItemsFromFile"
        QT_MOC_LITERAL(156, 5),  // "date1"
        QT_MOC_LITERAL(162, 15),  // "saveItemsToFile"
        QT_MOC_LITERAL(178, 9),  // "itemToAdd"
        QT_MOC_LITERAL(188, 34)   // "on_pushSaveAsRoutineButton_cl..."
    },
    "TaskManager",
    "on_addPushButton_clicked",
    "",
    "on_removePushButton_clicked",
    "on_calendarWidget_selectionChanged",
    "on_routinePushButton_clicked",
    "checked",
    "loadItemsFromFile",
    "date1",
    "saveItemsToFile",
    "itemToAdd",
    "on_pushSaveAsRoutineButton_clicked"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSTaskManagerENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   56,    2, 0x08,    1 /* Private */,
       3,    0,   57,    2, 0x08,    2 /* Private */,
       4,    0,   58,    2, 0x08,    3 /* Private */,
       5,    1,   59,    2, 0x08,    4 /* Private */,
       7,    1,   62,    2, 0x08,    6 /* Private */,
       9,    2,   65,    2, 0x08,    8 /* Private */,
      11,    0,   70,    2, 0x08,   11 /* Private */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool,    6,
    QMetaType::Void, QMetaType::QString,    8,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    8,   10,
    QMetaType::Void,

       0        // eod
};

Q_CONSTINIT const QMetaObject TaskManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QDialog::staticMetaObject>(),
    qt_meta_stringdata_CLASSTaskManagerENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSTaskManagerENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSTaskManagerENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<TaskManager, std::true_type>,
        // method 'on_addPushButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_removePushButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_calendarWidget_selectionChanged'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_routinePushButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'loadItemsFromFile'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'saveItemsToFile'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'on_pushSaveAsRoutineButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void TaskManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<TaskManager *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->on_addPushButton_clicked(); break;
        case 1: _t->on_removePushButton_clicked(); break;
        case 2: _t->on_calendarWidget_selectionChanged(); break;
        case 3: _t->on_routinePushButton_clicked((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 4: _t->loadItemsFromFile((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 5: _t->saveItemsToFile((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 6: _t->on_pushSaveAsRoutineButton_clicked(); break;
        default: ;
        }
    }
}

const QMetaObject *TaskManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *TaskManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSTaskManagerENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QDialog::qt_metacast(_clname);
}

int TaskManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QDialog::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 7;
    }
    return _id;
}
QT_WARNING_POP
