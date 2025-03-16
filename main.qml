import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12  // For gradients and effects
import QtQuick.Controls.Material 2.12  // For Material style

Window {
    width: 800
    height: 500
    visible: true
    title: qsTr("INFO Transmission")
property int globalIndex: -1
    property int deleteInde: -1
    property int showflag : 0
    property int updflag: 0
    // Define color properties for easy management
    property color backgroundColor: "#0080ff"  // Light gray background
    property color primaryColor: "#2196F3"     // Material Blue
    property color accentColor: "#FF4081"      // Pink accent
    property color textColor: "#212121"        // Dark text
    property color buttonColor: "#98a39a"      // Darker blue for buttons
    property color buttonPressedColor: "#1565C0" // Even darker blue for pressed state
    property color headerColor: "#99ff99"      // Very light blue for table header

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#4fbaf0" }  // Deep Indigo
            GradientStop { position: 1.0; color: "#04498a" }  // Deep Blue
        }
        // Labels with updated colors
        Label {
            id: productN
            x: 25
            y: 30
            text: "Product Name"
            font.pixelSize: 20
            color: textColor
            font.bold: true
        }

        Label {
            id: volume
            x: 215
            y: 30
            text: "Volume"
            font.pixelSize: 20
            color: textColor
            font.bold: true
        }

        Label {
            id: marketcap
            x: 415
            y: 30
            text: "Market Capital"
            font.pixelSize: 20
            color: textColor
            font.bold: true
        }

        Label {
            id: marketreting
            x: 615
            y: 30
            text: "Rating"
            font.pixelSize: 20
            color: textColor
            font.bold: true
        }

        // TextFields with updated style
        TextField {
            id: pn
            x: 25
            y: 60
            width: 150
            height: 30
            placeholderText: "Product Name"
            font.pointSize: 13
            background: Rectangle {
                radius: 4
                border.color: pn.focused ? primaryColor : "#BDBDBD"
                border.width: pn.focused ? 2 : 1
            }
            validator: RegExpValidator { regExp: /[a-zA-Z]+/ }
        }

        TextField {
            id: vol
            x: 215
            y: 60
            width: 150
            height: 30
            placeholderText: "Volume"
            font.pointSize: 13
            background: Rectangle {
                radius: 4
                border.color: vol.focused ? primaryColor : "#BDBDBD"
                border.width: vol.focused ? 2 : 1
            }
            validator: RegExpValidator { regExp: /[0-9]+/ }
        }

        TextField {
            id: mc
            x: 415
            y: 60
            width: 150
            height: 30
            placeholderText: "Market Capital"
            font.pointSize: 13
            background: Rectangle {
                radius: 4
                border.color: mc.focused ? primaryColor : "#BDBDBD"
                border.width: mc.focused ? 2 : 1
            }
            validator: RegExpValidator { regExp: /^\d*\.?\d+$/ }
        }

        TextField {
            id: rating
            x: 615
            y: 60
            width: 150
            height: 30
            placeholderText: "Rating"
            font.pointSize: 13
            background: Rectangle {
                radius: 4
                border.color: rating.focused ? primaryColor : "#BDBDBD"
                border.width: rating.focused ? 2 : 1
            }
            validator: RegExpValidator { regExp: /^-?\d*\.?\d+$/ }

        }

        // Table with updated colors

            Rectangle {
                x: 25
                y: 115
            width: 540
            height: 40
            color: headerColor

            Row {
                width: parent.width
                height: parent.height

                Rectangle {
                    width: parent.width/4
                    height: parent.height
                    color: headerColor
                    border.color: "#BDBDBD"
                    Text {
                        text: "Product Name"
                        anchors.centerIn: parent
                        font.bold: true
                        color: textColor
                        font.pixelSize: 15
                    }
                }
                Rectangle {
                    width: parent.width/4
                    height: parent.height
                    color: headerColor
                    border.color: "#BDBDBD"
                    Text {
                        text: "Volume"
                        anchors.centerIn: parent
                        font.bold: true
                        color: textColor
                         font.pixelSize: 15
                    }
                }
                Rectangle {
                    width: parent.width/4
                    height: parent.height
                    color: headerColor
                    border.color: "#BDBDBD"
                    Text {
                        text: "Market Capital"
                        anchors.centerIn: parent
                        font.bold: true
                        color: textColor
                         font.pixelSize: 15
                    }
                }
                Rectangle {
                    width: parent.width/4
                    height: parent.height
                    color: headerColor
                    border.color: "#BDBDBD"
                    Text {
                        text: "Rating"
                        anchors.centerIn: parent
                        font.bold: true
                        color: textColor
                         font.pixelSize: 15
                    }
                }
            }

        }

        ListView {
            id: tableView
            x: 25
            y: 155
            width: 540
            height: 340
            contentHeight: contentItem.childrenRect.height
            interactive: true
            clip: true

            model: ListModel {
                id: p_table

            }
                    // ... existing properties ...

            //  headerPositioning: ListView.OverlayHeader
              boundsBehavior: Flickable.StopAtBounds


            delegate: Rectangle {
                width: tableView.width
                height: 40
                color: index % 2 === 0 ? "#FFFFFF" : "#F5F5F5"  // Alternating row colors



//............................. Add this MouseArea inside the ListView right click.........................................
                MouseArea {
                        anchors.fill: parent

                            // Double-click handling
                            onDoubleClicked: {
                                // Retrieve the data of the double-clicked item
                                var itemData = p_table.get(index)

                                // Example actions:
//                                console.log("Double-clicked item:",
                                    pn.text= itemData.product_name
                                    vol.text= itemData.volum_
                                    mc.text= itemData.market_cap
                                    rating.text= itemData.rating_

                               console.log(index)
                               globalIndex= index
                                updflag=1
                            }

                            // Right-click context menu (keeping previous functionality)
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: {
                                if (mouse.button === Qt.RightButton) {
                                    var indexItem = tableView.indexAt(mouse.x, tableView.contentY + mouse.y)

                                    // Fallback method to ensure last item is detected
                                    if (indexItem === -1) {
                                        indexItem = tableView.count - 1
                                    }

                                    if (indexItem >= 0) {
                                        contextMenu.index = indexItem
                                        contextMenu.popup()
                                        deleteInde=index
                                    }
                                }
                            }
                        }
 //...................... rest of existing ListView code ...........
                Row {
                    width: parent.width
                    height: parent.height

                    Rectangle {
                        width: parent.width/4
                        height: parent.height
                        color: "transparent"
                        border.color: "#BDBDBD"
                        Text {
                            text: product_name
                            anchors.centerIn: parent
                            color: textColor
                             font.pixelSize: 14
                        }
                    }
                    Rectangle {
                        width: parent.width/4
                        height: parent.height
                        color: "transparent"
                        border.color: "#BDBDBD"
                        Text {
                            text:volum_
                            anchors.centerIn: parent
                            color: textColor
                            font.pixelSize: 14
                        }
                    }
                    Rectangle {
                        width: parent.width/4
                        height: parent.height
                        color: "transparent"
                        border.color: "#BDBDBD"
                        Text {
                            text: market_cap
                            anchors.centerIn: parent
                            color: textColor
                            font.pixelSize: 14
                        }
                    }

                    Rectangle {
                        width: parent.width/4
                        height: parent.height
                        color: "transparent"
                        border.color: "#BDBDBD"
                        Text {
                            text: rating_
                            anchors.centerIn: parent
                            color: textColor
                            font.pixelSize: 14
                        }
                    }
                }
              }


  }

//.........................................delete.............................................
        Menu {
            id: contextMenu
            // Property to store the index of the item to be deleted
            property int index:-1

            // Menu item for deletion

            MenuItem {

                text: "Delete"

                font.pointSize: 14
                font.bold: true
                onTriggered: {
                    // Remove the item from the ListModel if a valid index is selected
                    if (deleteInde >= 0) {
                        console.log(deleteInde)
                        var Data = p_table.get(deleteInde)
                        console.log(Data.product_name)
                        g.deleteItem( Data.product_name)

                        p_table.remove(deleteInde)

                         }
                     }
                  }
             }

//.................................... Buttons with updated style...................................
        Button {
            id: but
            x: 664
            y: 115
            width: 100
            height: 40
            
            contentItem: Text {
                text: "Add"
                color: textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
                font.bold: true
            }
            
//            background: Rectangle {
//                color: but.pressed ? buttonPressedColor : buttonColor
//                radius: 4
//            }
            background: Rectangle {
              //  color: Qt.rgba(1, 1, 1, 0.2)
                  color: but.pressed ? buttonPressedColor : buttonColor
                radius: 3
                border.color: Qt.rgba(1, 1, 1, 0.3)
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    radius: 4
                    samples: 9
                    color: "#000000"
                }
            
              }

              onClicked:
                        {
                           //  console.log(g.datatoqml())

                  var item,string
                 var i,flag=1
                  for(i=0;i<p_table.count;i++)
                  {
                      item=p_table.get(i)
                       string= item.product_name
                      if(string===pn.text)
                      {
                          flag=0
                      }
                  }


                            if (pn.text !== "" && vol.text !== "" && mc.text !== "" && rating.text !== "" && flag )
                            {
                                p_table.append({
                                          "product_name": pn.text,
                                          "volum_": vol.text,
                                          "market_cap": mc.text,
                                            "rating_":rating.text

                                            })

                                      // Clear the text fields after adding
                                      pn.text = ""
                                      vol.text = ""
                                      mc.text = ""
                                      rating.text = ""
                                 }
                        }
            }

        Button {
            id: buttonupdate
            x: 664
            y: 180
            width: 100
            height: 40
            
            contentItem: Text {
                text: "Update"
                color: textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
                font.bold: true
            }
            
//            background: Rectangle {
//                color: buttonupdate.pressed ? buttonPressedColor : buttonColor
//                radius: 4
//            }
            background: Rectangle {
              //  color: Qt.rgba(1, 1, 1, 0.2)
                 color: buttonupdate.pressed ? buttonPressedColor : buttonColor
                radius: 3
                border.color: Qt.rgba(1, 1, 1, 0.3)
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    radius: 4
                    samples: 9
                    color: "#000000"
                }

            }
            
            onClicked:
            {
              var str_pname

                console.log("update pressed")
                console.log(globalIndex)

        if (pn.text !== "" && vol.text !== "" && mc.text !== "" && rating.text !== "" )
        {

                if (globalIndex >= 0 && globalIndex < p_table.count) {
                    p_table.set(globalIndex,{
                              "product_name": pn.text,
                              "volum_": vol.text,
                              "market_cap": mc.text,
                                "rating_":rating.text

                                })
                    pn.text = ""
                    vol.text = ""
                    mc.text = ""
                    rating.text = ""
                    str_pname=p_table.get(globalIndex)

                    g.updateItem(str_pname.product_name,str_pname.volum_+" "+str_pname.market_cap+" "+str_pname.rating_)
                           }

       }
            }
        }

        Button {
            id: buttonsave

            x: 664
            y:310
            width: 100
            height: 40
            
            contentItem: Text {
                text: "Save"
                color: textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
                font.bold: true
            }
            
//            background: Rectangle {
//                color: buttondelete.pressed ? "#D32F2F" : "#F44336"  // Red color for delete
//                radius: 4
//            }
            background: Rectangle {
              //  color: Qt.rgba(1, 1, 1, 0.2)
                 color: buttonsave.pressed ? "#4CAF50" : "#02ab21"
                radius: 3
                border.color: Qt.rgba(1, 1, 1, 0.3)
                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    radius: 6
                    samples: 9
                    color: "#000000"
                }

        }
            onClicked:
            {
                console.log("save pressed")
                var i,item,strpn,strvol,strmc,strrating
                if(showflag)
                    i=p_table.count
                else
                    i=0

                for(;i<p_table.count;i++)
                {
                    item=p_table.get(i)
                     strpn= item.product_name
                    strvol=item.volum_
                    strmc=item.market_cap
                    strrating=item.rating_

                    g.datafromqml(strpn+" "+strvol+" "+strmc+" "+strrating)


                }
            }
   }


    Button {
        id: buttonshow
        x: 664
        y: 245
        width: 100
        height: 40

        contentItem: Text {
            text: "Show"
            color: textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 14
            font.bold: true
        }

//            background: Rectangle {
//                color: buttonsave.pressed ? "#388E3C" : "#4CAF50"  // Green color for save
//                radius: 4
//            }
        background: Rectangle {
          //  color: Qt.rgba(1, 1, 1, 0.2)
             color: buttonshow.pressed ?  buttonPressedColor : buttonColor
            radius: 3
            border.color: Qt.rgba(1, 1, 1, 0.3)
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 6
                samples: 9
                color: "#000000"
            }

        }

        onClicked:
        {

               showflag :1
            p_table.clear()
            var string= g.datatoqml()

            var list=string.split("|")
            var i=0,j=list.length-1;

 console.log(j)
            do
            {
               var list2=list[i].split(" ")

            p_table.append({
                      "product_name": list2[0],
                      "volum_": list2[1],
                      "market_cap": list2[2],
                        "rating_":list2[3]

                        })
              i++


            }while(i<j);
       }
    }

    Button {
        id: buttonconn
        x: 664
        y: 375
        width: 100
        height: 35

        contentItem: Text {
            text: "Connect"
            color: textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 14
            font.bold: true
        }

//            background: Rectangle {
//                color: buttonsave.pressed ? "#388E3C" : "#4CAF50"  // Green color for save
//                radius: 4
//            }
        background: Rectangle {
          //  color: Qt.rgba(1, 1, 1, 0.2)
             color: buttonconn.pressed ?  buttonPressedColor : buttonColor
            radius: 3
            border.color: Qt.rgba(1, 1, 1, 0.3)
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 6
                samples: 9
                color: "#000000"
            }

        }

        onClicked:
        {
            console.log("connect pressed")
            g.connect()
        }
    }

    Button {
        id: buttonsend
        x: 664
        y: 440
        width: 100
        height: 35

        contentItem: Text {
            text: "Send"
            color: textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 14
            font.bold: true
        }

//            background: Rectangle {
//                color: buttonsave.pressed ? "#388E3C" : "#4CAF50"  // Green color for save
//                radius: 4
//            }
        background: Rectangle {
          //  color: Qt.rgba(1, 1, 1, 0.2)
             color: buttonsend.pressed ?  buttonPressedColor : buttonColor
            radius: 3
            border.color: Qt.rgba(1, 1, 1, 0.3)
            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                radius: 6
                samples: 9
                color: "#000000"
            }

        }


        onClicked:
        {
            var STRING,i,item,pn ,strvol,strmc, strrating
            STRING=""
            console.log("send pressed")
            for(i=0;i<p_table.count;i++)
            {
                item=p_table.get(i)
                pn =item.product_name
                strvol=item.volum_
                strmc=item.market_cap
                strrating=item.rating_

                STRING=STRING+pn+","+strvol+","+strmc+","+strrating+"\n"

            }
            g.send_clicked(STRING)

            console.log(STRING)
           // console.log(STRING)
        }
    }
}

}
