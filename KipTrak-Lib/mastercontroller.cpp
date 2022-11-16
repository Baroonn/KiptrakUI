#include "mastercontroller.h"

class MasterController::Implementation
{
public:
Implementation(MasterController* _masterController)
: masterController(_masterController)
{
    navigationController = new NavigationController(masterController);
    newAssignment = new Assignment(masterController);
    networkAccessManager = new NetworkAccessManager(masterController);
    assignmentWebRequest = new WebRequest(masterController, networkAccessManager,
    QUrl("http://kiptrak.azurewebsites.net/api/assignments"));
    QObject::connect(assignmentWebRequest, &WebRequest::requestComplete, masterController, &MasterController::onReplyReceived);
}
MasterController* masterController{nullptr};
Assignment* newAssignment{nullptr};
NavigationController* navigationController{nullptr};
NetworkAccessManager* networkAccessManager{nullptr};
WebRequest* assignmentWebRequest{nullptr};
QString welcomeMessage = "This is MasterController to Major Tom";
};

MasterController::MasterController(QObject *parent)
    : QObject{parent}
{
    implementation.reset(new Implementation(this));
}

MasterController::~MasterController()
{
}

NavigationController* MasterController::navigationController()
{
return implementation->navigationController;
}
//const QString& MasterController::welcomeMessage() const
//{
//return implementation->welcomeMessage;
//}
Assignment* MasterController::newAssignment()
{
    return implementation->newAssignment;
}

WebRequest* MasterController::webRequest()
{
    return implementation->assignmentWebRequest;
}

void MasterController::onReplyReceived(int statusCode, QByteArray body)
{
    qDebug() << "Received RSS request response code " << statusCode << ":";
    qDebug() << body;
}
