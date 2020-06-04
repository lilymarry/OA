#ifndef _HC_NET_SDK_H_
#define _HC_NET_SDK_H_


#ifdef __cpluscplus
#define NET_DVR_API extern
#else
#define NET_DVR_API
#endif


#ifdef __cplusplus
extern "C"
{
#endif

#ifndef __PLAYRECT_defined
#define __PLAYRECT_defined
	typedef struct __PLAYRECT
	{
		int x;                               
		int y;                                  
		int uWidth;                            
		int uHeight;                            
	}PLAYRECT;
#endif

#ifndef __HWND_defined
#define __HWND_defined
	typedef void* HWND;
#endif

	typedef struct tagInitInfo
	{
		int uWidth;
		int uHeight;
	}INITINFO;


	typedef 	uint32_t  		DWORD;
	typedef   	uint16_t 		WORD;
	typedef		uint16_t  		USHORT;
	typedef  	unsigned char	BYTE;
	typedef 	int32_t			LONG;

	typedef     uint32_t    	UINT;
	typedef 	void* 			LPVOID;
	typedef 	void* 			HANDLE;
	typedef     uint32_t* 	    LPDWORD;
	typedef     uint16_t*       LPWORD;

#define 	TRUE	1
#define		FALSE	0
#define     __stdcall 
#define     CALLBACK 

//�궨��
//�궨��
#define MAX_NAMELEN			    16		//DVR���ص�½��
#define NAME_LEN			    32      //�û�������
#define PASSWD_LEN			    16      //���볤��
#define SERIALNO_LEN		    48      //���кų���
#define MACADDR_LEN			    6       //mac��ַ����
#define MAX_ETHERNET		    2       //�豸������̫����
#define PATHNAME_LEN		    128     //·������
#define MAX_PRESET_V13          16      //Ԥ�õ�
#define MAX_DOMAIN_NAME		    64		/* ����������� */

#define MAX_TIMESEGMENT_V30	    8       //9000�豸���ʱ�����
#define MAX_TIMESEGMENT		    4       //8000�豸���ʱ�����

#define MAX_SHELTERNUM			4       //8000�豸����ڵ�������
#define MAX_DAYS				7       //ÿ������
#define PHONENUMBER_LEN			32      //pppoe���ź�����󳤶�

#define MAX_DISKNUM_V30			33		//9000�豸���Ӳ����/* ���33��Ӳ��(����16������SATAӲ�̡�1��eSATAӲ�̺�16��NFS��) */
#define MAX_DISKNUM		        16      //8000�豸���Ӳ����
#define MAX_DISKNUM_V10		    8       //1.2�汾֮ǰ�汾

#define MAX_USERNUM_V30			32      //9000�豸����û���
#define MAX_USERNUM			    16      //8000�豸����û���
#define MAX_EXCEPTIONNUM_V30	32      //9000�豸����쳣������
#define MAX_EXCEPTIONNUM		16      //8000�豸����쳣������
#define MAX_LINK				6       //8000�豸��ͨ�������Ƶ��������

#define MAX_STRINGNUM_V30		8		//9000�豸���OSD�ַ�������
#define MAX_STRINGNUM			4       //8000�豸���OSD�ַ�������
#define MAX_STRINGNUM_EX		8       //8000������չ
#define MAX_AUXOUT_V30			16      //9000�豸����������
#define MAX_AUXOUT			    4       //8000�豸����������
#define MAX_HD_GROUP			16      //9000�豸���Ӳ������
#define MAX_NFS_DISK			8       //8000�豸���NFSӲ����

#define MAXPROGRESS		        100     //�ط�ʱ�����ٷ���
#define MAX_SERIALNUM	        2       //8000�豸֧�ֵĴ����� 1-232�� 2-485
#define CARDNUM_LEN		        20      //���ų���
#define MAX_VIDEOOUT_V30        4       //9000�豸����Ƶ�����
#define MAX_VIDEOOUT	        2       //8000�豸����Ƶ�����

#define MAX_PRESET_V30			    256		/* 9000�豸֧�ֵ���̨Ԥ�õ��� */
#define MAX_TRACK_V30			    256		/* 9000�豸֧�ֵ���̨�켣�� */
#define MAX_CRUISE_V30			    256		/* 9000�豸֧�ֵ���̨Ѳ���� */
#define MAX_PRESET				    128		/* 8000�豸֧�ֵ���̨Ԥ�õ��� */
#define MAX_TRACK				    128		/* 8000�豸֧�ֵ���̨�켣�� */
#define MAX_CRUISE				    128		/* 8000�豸֧�ֵ���̨Ѳ���� */

#define CRUISE_MAX_PRESET_NUMS	    32 	    /* һ��Ѳ������Ѳ���� */

#define MAX_AUDIO			        1       //8000�����Խ�ͨ����
#define MAX_AUDIO_V30			    2       //9000�����Խ�ͨ����
#define MAX_CHANNUM			        16      //8000�豸���ͨ����
#define MAX_ALARMIN			        16      //8000�豸��󱨾�������
#define MAX_ALARMOUT		        4       //8000�豸��󱨾������

#define MAX_ANALOG_CHANNUM          32      //���32��ģ��ͨ��
#define MAX_ANALOG_ALARMOUT         32      //���32·ģ�ⱨ����� 
#define MAX_ANALOG_ALARMIN          32      //���32·ģ�ⱨ������

#define MAX_IP_DEVICE               32      //�����������IP�豸��
#define MAX_IP_DEVICE_V40           64      //�����������IP�豸�� �������64�� IVMS 2000�����豸
#define MAX_IP_CHANNEL              32      //�����������IPͨ����
#define MAX_IP_ALARMIN              128     //����������౨��������
#define MAX_IP_ALARMOUT             64      //����������౨�������


/* ���֧�ֵ�ͨ���� ���ģ��������IP֧�� */
#define MAX_CHANNUM_V30               ( MAX_ANALOG_CHANNUM + MAX_IP_CHANNEL )//64
#define MAX_ALARMOUT_V30              ( MAX_ANALOG_ALARMOUT + MAX_IP_ALARMOUT )//96
#define MAX_ALARMIN_V30               ( MAX_ANALOG_ALARMIN + MAX_IP_ALARMIN )//160

/*******************ȫ�ִ����� begin**********************/	
#define NET_DVR_NOERROR 					0	//û�д���
#define NET_DVR_PASSWORD_ERROR 				1	//�û����������
#define NET_DVR_NOENOUGHPRI 				2	//Ȩ�޲���
#define NET_DVR_NOINIT 						3	//û�г�ʼ��
#define NET_DVR_CHANNEL_ERROR 				4	//ͨ���Ŵ���
#define NET_DVR_OVER_MAXLINK 				5	//���ӵ�DVR�Ŀͻ��˸����������
#define NET_DVR_VERSIONNOMATCH				6	//�汾��ƥ��
#define NET_DVR_NETWORK_FAIL_CONNECT		7	//���ӷ�����ʧ��
#define NET_DVR_NETWORK_SEND_ERROR			8	//�����������ʧ��
#define NET_DVR_NETWORK_RECV_ERROR			9	//�ӷ�������������ʧ��
#define NET_DVR_NETWORK_RECV_TIMEOUT		10	//�ӷ������������ݳ�ʱ
#define NET_DVR_NETWORK_ERRORDATA			11	//���͵���������
#define NET_DVR_ORDER_ERROR					12	//���ô������
#define NET_DVR_OPERNOPERMIT				13	//�޴�Ȩ��
#define NET_DVR_COMMANDTIMEOUT				14	//DVR����ִ�г�ʱ
#define NET_DVR_ERRORSERIALPORT				15	//���ںŴ���
#define NET_DVR_ERRORALARMPORT				16	//�����˿ڴ���
#define NET_DVR_PARAMETER_ERROR 			17  //��������
#define NET_DVR_CHAN_EXCEPTION				18	//������ͨ�����ڴ���״̬
#define NET_DVR_NODISK						19	//û��Ӳ��
#define NET_DVR_ERRORDISKNUM				20	//Ӳ�̺Ŵ���
#define NET_DVR_DISK_FULL					21	//������Ӳ����
#define NET_DVR_DISK_ERROR					22	//������Ӳ�̳���
#define NET_DVR_NOSUPPORT					23	//��������֧��
#define NET_DVR_BUSY						24	//������æ
#define NET_DVR_MODIFY_FAIL					25	//�������޸Ĳ��ɹ�
#define NET_DVR_PASSWORD_FORMAT_ERROR		26	//���������ʽ����ȷ
#define NET_DVR_DISK_FORMATING				27	//Ӳ�����ڸ�ʽ����������������
#define NET_DVR_DVRNORESOURCE				28	//DVR��Դ����
#define	NET_DVR_DVROPRATEFAILED				29  //DVR����ʧ��
#define NET_DVR_OPENHOSTSOUND_FAIL 			30  //��PC����ʧ��
#define NET_DVR_DVRVOICEOPENED 				31  //�����������Խ���ռ��
#define	NET_DVR_TIMEINPUTERROR				32  //ʱ�����벻��ȷ
#define	NET_DVR_NOSPECFILE					33  //�ط�ʱ������û��ָ�����ļ�
#define NET_DVR_CREATEFILE_ERROR			34	//�����ļ�����
#define	NET_DVR_FILEOPENFAIL				35  //���ļ�����
#define	NET_DVR_OPERNOTFINISH				36  //�ϴεĲ�����û�����
#define	NET_DVR_GETPLAYTIMEFAIL				37  //��ȡ��ǰ���ŵ�ʱ�����
#define	NET_DVR_PLAYFAIL					38  //���ų���
#define NET_DVR_FILEFORMAT_ERROR			39  //�ļ���ʽ����ȷ
#define NET_DVR_DIR_ERROR					40	//·������
#define NET_DVR_ALLOC_RESOURCE_ERROR		41  //��Դ�������
#define NET_DVR_AUDIO_MODE_ERROR			42	//����ģʽ����
#define NET_DVR_NOENOUGH_BUF				43	//������̫С
#define NET_DVR_CREATESOCKET_ERROR		 	44	//����SOCKET����
#define NET_DVR_SETSOCKET_ERROR				45	//����SOCKET����
#define NET_DVR_MAX_NUM						46	//�����ﵽ���
#define NET_DVR_USERNOTEXIST				47	//�û�������
#define NET_DVR_WRITEFLASHERROR				48  //дFLASH����
#define NET_DVR_UPGRADEFAIL					49  //DVR����ʧ��
#define NET_DVR_CARDHAVEINIT				50  //���뿨�Ѿ���ʼ����
#define NET_DVR_PLAYERFAILED				51	//���ò��ſ���ĳ������ʧ��
#define NET_DVR_MAX_USERNUM					52  //�豸���û����ﵽ���
#define NET_DVR_GETLOCALIPANDMACFAIL		53  //��ÿͻ��˵�IP��ַ�������ַʧ��
#define NET_DVR_NOENCODEING					54	//��ͨ��û�б���
#define NET_DVR_IPMISMATCH					55	//IP��ַ��ƥ��
#define NET_DVR_MACMISMATCH					56	//MAC��ַ��ƥ��
#define NET_DVR_UPGRADELANGMISMATCH			57	//�����ļ����Բ�ƥ��
#define NET_DVR_MAX_PLAYERPORT				58	//������·���ﵽ���
#define NET_DVR_NOSPACEBACKUP				59	//�����豸��û���㹻�ռ���б���
#define NET_DVR_NODEVICEBACKUP				60	//û���ҵ�ָ���ı����豸
#define NET_DVR_PICTURE_BITS_ERROR			61	//ͼ����λ����������24ɫ
#define NET_DVR_PICTURE_DIMENSION_ERROR		62	//ͼƬ��*���ޣ� ��128*256
#define NET_DVR_PICTURE_SIZ_ERROR			63	//ͼƬ��С���ޣ���100K
#define NET_DVR_LOADPLAYERSDKFAILED			64	//���뵱ǰĿ¼��Player Sdk����
#define NET_DVR_LOADPLAYERSDKPROC_ERROR		65	//�Ҳ���Player Sdk��ĳ���������
#define NET_DVR_LOADDSSDKFAILED				66	//���뵱ǰĿ¼��DSsdk����
#define NET_DVR_LOADDSSDKPROC_ERROR		    67	//�Ҳ���DsSdk��ĳ���������
#define NET_DVR_DSSDK_ERROR					68	//����Ӳ�����DsSdk��ĳ������ʧ��
#define NET_DVR_VOICEMONOPOLIZE				69	//��������ռ
#define NET_DVR_JOINMULTICASTFAILED			70	//����ಥ��ʧ��
#define NET_DVR_CREATEDIR_ERROR				71	//������־�ļ�Ŀ¼ʧ��
#define NET_DVR_BINDSOCKET_ERROR			72	//���׽���ʧ��
#define NET_DVR_SOCKETCLOSE_ERROR			73	//socket�����жϣ��˴���ͨ�������������жϻ�Ŀ�ĵز��ɴ�
#define NET_DVR_USERID_ISUSING			    74	//ע��ʱ�û�ID���ڽ���ĳ����
#define NET_DVR_SOCKETLISTEN_ERROR			75	//����ʧ��
#define NET_DVR_PROGRAM_EXCEPTION			76	//�����쳣
#define NET_DVR_WRITEFILE_FAILED			77	//д�ļ�ʧ��
#define NET_DVR_FORMAT_READONLY				78  //��ֹ��ʽ��ֻ��Ӳ��
#define NET_DVR_WITHSAMEUSERNAME		    79  //�û����ýṹ�д�����ͬ���û���
#define NET_DVR_DEVICETYPE_ERROR            80  /*�������ʱ�豸�ͺŲ�ƥ��*/
#define NET_DVR_LANGUAGE_ERROR              81  /*�������ʱ���Բ�ƥ��*/
#define NET_DVR_PARAVERSION_ERROR           82  /*�������ʱ����汾��ƥ��*/
#define NET_DVR_IPCHAN_NOTALIVE             83  /*Ԥ��ʱ���IPͨ��������*/
#define NET_DVR_RTSP_SDK_ERROR				84	/*���ظ���IPCͨѶ��StreamTransClient.dllʧ��*/
#define NET_DVR_CONVERT_SDK_ERROR			85	/*����ת���ʧ��*/
#define NET_DVR_IPC_COUNT_OVERFLOW			86  /*��������ip����ͨ����*/

/**********************��̨�������� begin*************************/	
#define LIGHT_PWRON		2	/* ��ͨ�ƹ��Դ */
#define WIPER_PWRON		3	/* ��ͨ��ˢ���� */
#define FAN_PWRON		4	/* ��ͨ���ȿ��� */
#define HEATER_PWRON	5	/* ��ͨ���������� */
#define AUX_PWRON1		6	/* ��ͨ�����豸���� */
#define AUX_PWRON2		7	/* ��ͨ�����豸���� */
#define SET_PRESET		8	/* ����Ԥ�õ� */
#define CLE_PRESET		9	/* ���Ԥ�õ� */

#define ZOOM_IN			11	/* �������ٶ�SS���(���ʱ��) */
#define ZOOM_OUT		12	/* �������ٶ�SS��С(���ʱ�С) */
#define FOCUS_NEAR      13  /* �������ٶ�SSǰ�� */
#define FOCUS_FAR       14  /* �������ٶ�SS��� */
#define IRIS_OPEN       15  /* ��Ȧ���ٶ�SS���� */
#define IRIS_CLOSE      16  /* ��Ȧ���ٶ�SS��С */

#define TILT_UP			21	/* ��̨��SS���ٶ����� */
#define TILT_DOWN		22	/* ��̨��SS���ٶ��¸� */
#define PAN_LEFT		23	/* ��̨��SS���ٶ���ת */
#define PAN_RIGHT		24	/* ��̨��SS���ٶ���ת */
#define UP_LEFT			25	/* ��̨��SS���ٶ���������ת */
#define UP_RIGHT		26	/* ��̨��SS���ٶ���������ת */
#define DOWN_LEFT		27	/* ��̨��SS���ٶ��¸�����ת */
#define DOWN_RIGHT		28	/* ��̨��SS���ٶ��¸�����ת */
#define PAN_AUTO		29	/* ��̨��SS���ٶ������Զ�ɨ�� */

#define FILL_PRE_SEQ	30	/* ��Ԥ�õ����Ѳ������ */
#define SET_SEQ_DWELL	31	/* ����Ѳ����ͣ��ʱ�� */
#define SET_SEQ_SPEED	32	/* ����Ѳ���ٶ� */
#define CLE_PRE_SEQ		33	/* ��Ԥ�õ��Ѳ��������ɾ�� */
#define STA_MEM_CRUISE	34	/* ��ʼ��¼�켣 */
#define STO_MEM_CRUISE	35	/* ֹͣ��¼�켣 */
#define RUN_CRUISE		36	/* ��ʼ�켣 */
#define RUN_SEQ			37	/* ��ʼѲ�� */
#define STOP_SEQ		38	/* ֹͣѲ�� */
#define GOTO_PRESET		39	/* ����ת��Ԥ�õ� */
/**********************��̨�������� end*************************/

/**********************�طſ������� begin*************************/
#define NET_DVR_PLAYSTART		1//��ʼ����
#define NET_DVR_PLAYPAUSE		3//��ͣ����
#define NET_DVR_PLAYRESTART		4//�ָ�����
#define NET_DVR_PLAYGETPOS		13//��ȡ�ļ��طŵĽ���
#define NET_DVR_GETTOTALFRAMES  16//��ȡ��ǰ�����ļ��ܵ�֡��(���ļ��طŵ�ʱ����Ч)
#define NET_DVR_GETTOTALTIME    17//��ȡ��ǰ�����ļ��ܵ�ʱ��(���ļ��طŵ�ʱ����Ч)
#define NET_DVR_SETSPEED		24//���������ٶ�
#define NET_DVR_PLAYGETTOTALLEN	27//��ȡ��ʱ��طŶ�Ӧʱ����ڵ������ļ����ܳ���
/**********************�طſ������� end*************************/

/**********************�����쳣���� begin************************/
#define EXCEPTION_EXCHANGE			0x8000	//�û�����ʱ�쳣
#define EXCEPTION_AUDIOEXCHANGE		0x8001	//�����Խ��쳣
#define EXCEPTION_ALARM				0x8002	//�����쳣
#define EXCEPTION_PREVIEW			0x8003	//����Ԥ���쳣
#define EXCEPTION_RECONNECT			0x8005	//Ԥ��ʱ����
#define EXCEPTION_ALARMRECONNECT	0x8006	//����ʱ����
#define EXCEPTION_PLAYBACK	        0x8010	//�ط��쳣
/**********************�����쳣���� end************************/

/*********************�����ص����� begin************************/
#define COMM_ALARM					0x1100	//8000������Ϣ�����ϴ�
#define COMM_ALARM_V30				0x4000	//9000������Ϣ�����ϴ�
/*********************�����ص����� end************************/

/**********************Ԥ���ص����� begin*********************/
#define NET_DVR_SYSHEAD				1		//ϵͳͷ����
#define NET_DVR_STREAMDATA			2		//��Ƶ�����ݣ�����������������Ƶ�ֿ�����Ƶ�����ݣ�
#define NET_DVR_AUDIOSTREAMDATA		3		//��Ƶ������
#define NET_DVR_STD_VIDEODATA	4	//��׼��Ƶ������
#define NET_DVR_STD_AUDIODATA	5	//��׼��Ƶ������
/**********************Ԥ���ص����� end*********************/

/************************�����ļ�����ֵ begin*************************/
#define NET_DVR_FILE_SUCCESS		1000	//����ļ���Ϣ
#define NET_DVR_FILE_NOFIND			1001	//û���ļ�
#define NET_DVR_ISFINDING			1002	//���ڲ����ļ�
#define	NET_DVR_NOMOREFILE			1003	//�����ļ�ʱû�и�����ļ�
#define	NET_DVR_FILE_EXCEPTION		1004	//�����ļ�ʱ�쳣
/************************�����ļ�����ֵ end*************************/

#define   STEP_READY       0    //׼������
#define   STEP_RECV_DATA   1    //��������������
#define   STEP_UPGRADE     2    //����ϵͳ
#define   STEP_BACKUP      3    //����ϵͳ
#define   STEP_SEARCH      255  //���������ļ�

/* �豸���� */
#define DVR							1				/*����δ�����dvr���ͷ���NETRET_DVR*/
#define ATMDVR						2				/*atm dvr*/
#define DVS							3				/*DVS*/
#define DEC							4				/* 6001D */
#define ENC_DEC						5				/* 6001F */
#define DVR_HC						6				/*8000HC*/
#define DVR_HT						7				/*8000HT*/
#define DVR_HF						8				/*8000HF*/
#define DVR_HS						9				/* 8000HS DVR(no audio) */
#define DVR_HTS						10              /* 8016HTS DVR(no audio) */
#define DVR_HB						11              /* HB DVR(SATA HD) */
#define DVR_HCS						12              /* 8000HCS DVR */
#define DVS_A						13              /* ��ATAӲ�̵�DVS */
#define DVR_HC_S					14              /* 8000HC-S */
#define DVR_HT_S					15              /* 8000HT-S */
#define DVR_HF_S					16              /* 8000HF-S */
#define DVR_HS_S					17              /* 8000HS-S */
#define ATMDVR_S					18              /* ATM-S */
#define DVR_7000H					19				/*7000Hϵ��*/
#define DEC_MAT						20              /*��·������*/
#define DVR_MOBILE					21				/* mobile DVR */                 
#define DVR_HD_S					22              /* 8000HD-S */
#define DVR_HD_SL					23				/* 8000HD-SL */
#define DVR_HC_SL					24				/* 8000HC-SL */
#define DVR_HS_ST					25				/* 8000HS_ST */
#define DVS_HW						26              /* 6000HW */
#define DS630X_D					27              /* ��·������ */
#define DS640X_HD					28				/*640X���������*/
#define DS610X_D                    29              /*610X������*/
#define IPCAM						30				/*IP �����*/
#define MEGA_IPCAM					31				/*852F&852MF*/
#define IPCAM_X62MF					32				/*862MF���Խ���9000�豸*/
#define ITCCAM                      35              /*���ܸ������������*/
#define ZOOMCAM                     38              /*һ���*/
#define IPDOME                      40              /*IP �������*/
#define IPDOME_MEGA200              41              /*IP 200��������*/
#define IPDOME_MEGA130              42              /*IP 130��������*/
#define IPDOME_AI                   43              /*IP �������ܿ���*/
#define TII_IPCAM                   44              /*�����ȳ��������*/
#define IPMOD						50				/*IP ģ��*/
#define IDS6501_HF_P                60              // 6501 ���� 
#define IDS6101_HF_A                61              //����ATM
#define IDS6002_HF_B                62				//˫�����٣�DS6002-HF/B
#define IDS6101_HF_B	            63              //��Ϊ������DS6101-HF/B DS6101-HF/B_SATA
#define IDS52XX		                64				//���ܷ�����IVMS
#define IDS90XX						65				// 9000����
#define IDS8104_AHL_S_HX            66				// ��������ʶ�� ATM
#define IDS8104_AHL_S_H             67              // ˽������ʶ�� ATM
#define IDS91XX						68				// 9100����
#define IIP_CAM_B                   69              // ������ΪIP�����
#define DS71XX_H					71				/* DS71XXH_S */
#define DS72XX_H_S					72				/* DS72XXH_S */
#define DS73XX_H_S					73				/* DS73XXH_S */
#define DS72XX_HF_S                 74              //DS72XX_HF_S
#define DS73XX_HFI_S                75              //DS73XX_HFI_S
#define DS76XX_H_S					76				/* DVR,e.g. DS7604_HI_S */
#define DS76XX_N_S					77				/* NVR,e.g. DS7604_NI_S */
#define DS81XX_HS_S					81				/* DS81XX_HS_S */
#define DS81XX_HL_S					82				/* DS81XX_HL_S */
#define DS81XX_HC_S					83				/* DS81XX_HC_S */
#define DS81XX_HD_S					84				/* DS81XX_HD_S */
#define DS81XX_HE_S					85				/* DS81XX_HE_S */
#define DS81XX_HF_S					86				/* DS81XX_HF_S */
#define DS81XX_AH_S					87				/* DS81XX_AH_S */
#define DS81XX_AHF_S				88				/* DS81XX_AHF_S */
#define DS90XX_HF_S		            90              /*DS90XX_HF_S*/
#define DS91XX_HF_S					91              /*DS91XX_HF_S*/
#define DS91XX_HD_S					92              /*91XXHD-S(MD)*/
#define IDS90XX_A					93				// 9000���� ATM
#define IDS91XX_A					94				// 9100���� ATM
#define DS95XX_N_S					95              /*DS95XX_N_S NVR �����κ����*/
#define DS96XX_N_SH					96              /*DS96XX_N_SH NVR*/
#define DS90XX_HF_SH                97              /*DS90XX_HF_SH */   
#define DS91XX_HF_SH                98              /*DS91XX_HF_SH */
#define DS_B10_XY                   100             /*��Ƶ�ۺ�ƽ̨�豸�ͺ�(X:�����Ƭ����Y:�����Ƭ��)*/
#define DS_6504HF_B10               101             /*��Ƶ�ۺ�ƽ̨�ڲ�������*/
#define DS_6504D_B10                102             /*��Ƶ�ۺ�ƽ̨�ڲ�������*/
#define DS_1832_B10                 103             /*��Ƶ�ۺ�ƽ̨�ڲ������*/
#define DS_6401HFH_B10              104             /*��Ƶ�ۺ�ƽ̨�ڲ����˰�*/
#define DS_65XXHC					105				//65XXHC DVS
#define DS_65XXHC_S					106				//65XXHC-SATA DVS
#define DS_65XXHF					107				//65XXHF DVS
#define DS_65XXHF_S					108				//65XXHF-SATA DVS
#define DS_6500HF_B                 109             //65 rack DVS
#define IVMS_6200_C                 110             //iVMS-6200(/C)  
#define IVMS_6200_B                 111             //iVMS-6200(/B)
#define DS_72XXHV_ST15				112				//72XXHV_ST15 DVR
#define DS_72XXHV_ST20				113				//72XXHV_ST20 DVR
#define IVMS_6200_T			        114             //IVMS-6200(/T)
#define IVMS_6200_BP                115             //IVMS-6200(/BP)
#define DS_81XXHC_ST				116				//DS_81XXHC_ST
#define DS_81XXHS_ST				117				//DS_81XXHS_ST
#define DS_81XXAH_ST				118				//DS_81XXAH_ST
#define DS_81XXAHF_ST				119				//DS_81XXAHF_ST
#define DS_66XXDVS				    120				//66XX DVS
#define DS_1964_B10                 121             /*��Ƶ�ۺ�ƽ̨�ڲ�������*/
#define DS_B10N04_IN				122             /*��Ƶ�ۺ�ƽ̨�ڲ���������*/
#define DS_B10N04_OUT				123             /*��Ƶ�ۺ�ƽ̨�ڲ��������*/
#define DS_B10N04_INTEL             124             /*��Ƶ�ۺ�ƽ̨�ڲ�����*/
#define DS_6408HFH_B10E_RM          125             //V6����
#define DS_B10N64F1_RTM             126             //V6��������DSP
#define DS_B10N64F1D_RTM            127             //V6������DSP
#define DS_B10_SDS                  128             //��Ƶ�ۺ�ƽ̨���������
#define DS_B10_DS                   129             //��Ƶ�ۺ�ƽ̨�������
#define DS_6401HFH_B10V    			130     	    //VGA���������
#define DS_6504D_B10B               131             /*��Ƶ�ۺ�ƽ̨�ڲ����������*/
#define DS_6504D_B10H               132             /*��Ƶ�ۺ�ƽ̨�ڲ����������*/
#define DS_6504D_B10V               133             /*��Ƶ�ۺ�ƽ̨�ڲ�VGA������*/
#define DS_6408HFH_B10S			    134             //��Ƶ�ۺ�ƽ̨SDI�Ӱ� 
#define DS_18XX_N      				135             /*�����������*/ 

#define DS_19DXX					145				/*������ر�������*/	
#define DS_19XX                     146             /*1900ϵ�б�������*/ 

#define IDS_8104_AHFL_S_H           171             // 8104ATM 
#define IDS_65XX_HF_A               172             // 65 ATM
#define IDS90XX_HF_RH               173             // 9000 ����RH
#define IDS91XX_HF_RH               174             // 9100 ����RH�豸
#define IDS_65XX_HF_B               175             // 65 ��Ϊ����
#define IDS_65XX_HF_P               176             // 65 ����ʶ��
#define IVMS_6200_F 		        177             // IVMS-6200(/F)
#define IVMS_6200_A                 178             //iVMS-6200(/A)

#define DS90XX_HF_RH                181             // 9000 RH    648
#define DS91XX_HF_RH                182             // 9100 RH�豸 648
#define DS78XX_S					183             // 78ϵ���豸 6446
#define DS81XXHW_S					185				// 81 Resolution 960 KY2011
#define DS81XXHW_ST					186             // DS81XXHW_ST  KY2011
#define DS91XXHW_ST					187             // DS91XXHW_ST  KY2011
#define DS91XX_ST					188             // DS91XX_ST netra
#define DS81XX_ST					189             // DS81XX_ST netra
#define DS81XXHX_ST					190             // DS81XXHDI_ST,DS81XXHE_ST ky2012
#define DS73XXHX_ST					191             // DS73XXHI_ST ky2012
#define DS81XX_SH                   192             // ��Ѷ81SH,81SHF
#define DS81XX_SN                   193             // ��Ѷ81SNL

#define DS96XXN_ST                  194             //NVR:DS96xxN_ST
#define DS86XXN_ST                  195             //NVR:DS86xxN_ST
#define DS80XXHF_ST                 196             //DVR:DS80xxHF_ST
#define DS90XXHF_ST                 197             //DVR:DS90xxHF_ST
#define DS76XXN_ST                  198             //NVR:DS76xxN_ST

#define ENCODER_SERVER				200				// ���뿨������
#define DECODER_SERVER              201				// ���뿨������
#define PCNVR_SERVER                202				// PCNVR�洢������

/******************************��������ȡ*********************************/
//������ȡ����
#define DEVICE_SOFTHARDWARE_ABILITY         0x001  //�豸��Ӳ������
#define DEVICE_NETWORK_ABILITY              0x002  //�豸��������
#define DEVICE_ENCODE_ALL_ABILITY           0x003  //�豸���б�������
#define	DEVICE_ENCODE_CURRENT               0x004  //�豸��ǰ��������
#define IPC_FRONT_PARAMETER			        0x005	 //ipcǰ�˲���1.0
#define IPC_UPGRADE_DESCRIPTION		        0x006	 //ipc������Ϣ
#define DEVICE_RAID_ABILITY                 0x007  //RAID����
#define DEVICE_ENCODE_ALL_ABILITY_V20       0x008	 //�豸���б�������2.0
#define IPC_FRONT_PARAMETER_V20		        0x009	 //ipcǰ�˲���2.0
#define DEVICE_ALARM_ABILITY                0x00a  //������������
#define DEVICE_DYNCHAN_ABILITY		        0x00b  //�豸����ͨ������
#define DEVICE_USER_ABILITY                 0x00c  //�豸�û������������
#define DEVICE_NETAPP_ABILITY               0x00d  //�豸����Ӧ�ò�������
#define DEVICE_VIDEOPIC_ABILITY             0x00e  //�豸ͼ���������
#define DEVICE_JPEG_CAP_ABILITY             0x00f  //�豸JPEGץͼ����
#define DEVICE_SERIAL_ABILITY               0x010  //RS232��RS485��������
#define DEVICE_ABILITY_INFO			        0x011	 //�豸ͨ���������ͣ������������ݷ��͵������ڵ�������
#define STREAM_ABILITY                      0x012  //������
#define SYSTEM_MANAGEMENT_ABILITY           0x013  //�豸ϵͳ��������
#define IP_VIEW_DEV_ABILITY					0x014  //IP���ӶԽ��ֻ�����
#define VCA_DEV_ABILITY 	                0x100  //�豸���ܷ�����������
#define VCA_CHAN_ABILITY                    0x110  //��Ϊ��������
#define MATRIXDECODER_ABILITY               0x200  //��·��������ʾ����������
#define VIDEOPLATFORM_ABILITY               0x210 //��Ƶ�ۺ�ƽ̨������
#define VIDEOPLATFORM_SBUCODESYSTEM_ABILITY 0x211 //��Ƶ�ۺ�ƽ̨������ϵͳ������
#define WALL_ABILITY                        0x212  //����ǽ������
#define MATRIX_ABILITY                      0x213  //SDI�������� 
#define DECODECARD_ABILITY                  0x220 //���뿨������������
#define VIDEOPLATFORM_ABILITY_V40           0x230 //��Ƶ�ۺ�ƽ̨������
#define MATRIXMANAGEDEVICE_ABILITY          0x240 //�����������������
#define MATRIXDECODER_ABILITY_V41           0x260 //������������
#define DECODER_ABILITY                     0x261 //������xml������
#define DECODECARD_ABILITY_V41              0x270 //���뿨������������V41
#define CODECARD_ABILITY                    0x271  //���뿨������
#define SNAPCAMERA_ABILITY                  0x300  //ץ�Ļ�������
#define ITC_TRIGGER_MODE_ABILITY            0x301  //����IPC�豸�Ĵ���ģʽ����
#define COMPRESSIONCFG_ABILITY              0x400  //��ȡѹ��������������
#define COMPRESSION_LIMIT                   0x401  //��ȡ��������ѹ��������������
#define PIC_CAPTURE_ABILITY			        0x402  //��ͼƬ�ֱ�����������
#define ALARMHOST_ABILITY                   0x500 //���籨������������ 
#define IT_DEVICE_ABILITY                   0x501  //���ܽ�ͨ������
#define	SCREENCONTROL_ABILITY		        0x600 	//����������������
#define	SCREENSERVER_ABILITY                0x610 	//����������������
#define FISHEYE_ABILITY                     0x700   //����������
#define LCD_SCREEN_ABILITY					0x800	//LCD��Ļ���� 2013-10-12

//sdk���绷��ö�ٱ���������Զ������
typedef enum _SDK_NET_ENV
{
	LOCAL_AREA_NETWORK = 0,
	WIDE_AREA_NETWORK
}SDK_NETWORK_ENVIRONMENT;

//NET_DVR_Login_V30()�����ṹ
typedef struct
{
	BYTE sSerialNumber[SERIALNO_LEN];  //���к�
	BYTE byAlarmInPortNum;		        //�����������
	BYTE byAlarmOutPortNum;		        //�����������
	BYTE byDiskNum;				    //Ӳ�̸���
	BYTE byDVRType;				    //�豸����, 1:DVR 2:ATM DVR 3:DVS ......
	BYTE byChanNum;				    //ģ��ͨ������
	BYTE byStartChan;			        //��ʼͨ����,����DVS-1,DVR - 1
	BYTE byAudioChanNum;                //����ͨ����
	BYTE byIPChanNum;					//�������ͨ����������λ  
	BYTE byZeroChanNum;			//��ͨ��������� //2010-01-16
	BYTE byMainProto;			//����������Э������ 0-private, 1-rtsp,2-ͬʱ֧��private��rtsp
	BYTE bySubProto;				//����������Э������0-private, 1-rtsp,2-ͬʱ֧��private��rtsp
	BYTE bySupport;        //������λ����Ϊ0��ʾ��֧�֣�1��ʾ֧�֣�
	//bySupport & 0x1, ��ʾ�Ƿ�֧����������
	//bySupport & 0x2, ��ʾ�Ƿ�֧�ֱ���
	//bySupport & 0x4, ��ʾ�Ƿ�֧��ѹ������������ȡ
	//bySupport & 0x8, ��ʾ�Ƿ�֧�ֶ�����
	//bySupport & 0x10, ��ʾ֧��Զ��SADP
	//bySupport & 0x20, ��ʾ֧��Raid������
	//bySupport & 0x40, ��ʾ֧��IPSAN Ŀ¼����
	//bySupport & 0x80, ��ʾ֧��rtp over rtsp
	BYTE bySupport1;        // ���������䣬λ����Ϊ0��ʾ��֧�֣�1��ʾ֧��
	//bySupport1 & 0x1, ��ʾ�Ƿ�֧��snmp v30
	//bySupport1 & 0x2, ֧�����ֻطź�����
	//bySupport1 & 0x4, �Ƿ�֧�ֲ������ȼ�	
	//bySupport1 & 0x8, �����豸�Ƿ�֧�ֲ���ʱ�����չ
	//bySupport1 & 0x10, ��ʾ�Ƿ�֧�ֶ������������33����
	//bySupport1 & 0x20, ��ʾ�Ƿ�֧��rtsp over http	
	//bySupport1 & 0x80, ��ʾ�Ƿ�֧�ֳ����±�����Ϣ2012-9-28, �һ���ʾ�Ƿ�֧��NET_DVR_IPPARACFG_V40�ṹ��
	BYTE bySupport2; /*������λ����Ϊ0��ʾ��֧�֣���0��ʾ֧��							
					 bySupport2 & 0x1, ��ʾ�������Ƿ�֧��ͨ��URLȡ������
					 bySupport2 & 0x2,  ��ʾ֧��FTPV40
					 bySupport2 & 0x4,  ��ʾ֧��ANR
					 bySupport2 & 0x8,  ��ʾ֧��CCD��ͨ����������
					 bySupport2 & 0x10,  ��ʾ֧�ֲ��������ش���Ϣ����֧��ץ�Ļ����� ���ϱ����ṹ��
					 bySupport2 & 0x20,  ��ʾ�Ƿ�֧�ֵ�����ȡ�豸״̬����
					 bySupport2 & 0x40,  ��ʾ�Ƿ������������豸*/
	WORD wDevType;              //�豸�ͺ�
	BYTE bySupport3; //��������չ��λ����Ϊ0��ʾ��֧�֣�1��ʾ֧��
	//bySupport3 & 0x1, ��ʾ�Ƿ������
	// bySupport3 & 0x4 ��ʾ֧�ְ������ã� ������� ͨ��ͼ��������������������IP�������롢������������
	// �û��������豸����״̬��JPEGץͼ����ʱ��ʱ��ץͼ��Ӳ��������� 
	//bySupport3 & 0x8Ϊ1 ��ʾ֧��ʹ��TCPԤ����UDPԤ�����ಥԤ���е�"��ʱԤ��"�ֶ���������ʱԤ������������ʹ�����ַ�ʽ������ʱԤ����������bySupport3 & 0x8Ϊ0ʱ����ʹ�� "˽����ʱԤ��"Э�顣
	//bySupport3 & 0x10 ��ʾ֧��"��ȡ����������Ҫ״̬��V40��"��
	//bySupport3 & 0x20 ��ʾ�Ƿ�֧��ͨ��DDNS��������ȡ��

	BYTE byMultiStreamProto;//�Ƿ�֧�ֶ�����,��λ��ʾ,0-��֧��,1-֧��,bit1-����3,bit2-����4,bit7-��������bit-8������
	BYTE byStartDChan;		//��ʼ����ͨ����,0��ʾ��Ч
	BYTE byStartDTalkChan;	//��ʼ���ֶԽ�ͨ���ţ�������ģ��Խ�ͨ���ţ�0��ʾ��Ч
	BYTE byHighDChanNum;		//����ͨ����������λ
	BYTE bySupport4;
	BYTE byLanguageType;// ֧����������,��λ��ʾ,ÿһλ0-��֧��,1-֧��  
	//  byLanguageType ����0 ��ʾ ���豸
	//  byLanguageType & 0x1��ʾ֧������
	//  byLanguageType & 0x2��ʾ֧��Ӣ��
	BYTE byRes2[9];		//����
}NET_DVR_DEVICEINFO_V30, *LPNET_DVR_DEVICEINFO_V30;

//�����Ԥ������
typedef struct
{
	LONG lChannel;//ͨ����
	LONG lLinkMode;//���λ(31)Ϊ0��ʾ��������Ϊ1��ʾ�ӣ�0��30λ��ʾ�������ӷ�ʽ: 0��TCP��ʽ,1��UDP��ʽ,2���ಥ��ʽ,3 - RTP��ʽ��4-RTP/RTSP,5-RSTP/HTTP 
	HWND hPlayWnd;//���Ŵ��ڵľ��,ΪNULL��ʾ������ͼ��
	char* sMultiCastIP;//�ಥ���ַ
	BYTE byProtoType; //Ӧ�ò�ȡ��Э�飬0-˽��Э�飬1-RTSPЭ��
	BYTE byRes[3];
}NET_DVR_CLIENTINFO, *LPNET_DVR_CLIENTINFO;

//Ѳ��������(˽��IP����ר��)
typedef struct
{
    BYTE	PresetNum;	//Ԥ�õ�
    BYTE	Dwell;		//ͣ��ʱ��
    BYTE	Speed;		//�ٶ�
    BYTE	Reserve;	//����
}NET_DVR_CRUISE_POINT, *LPNET_DVR_CRUISE_POINT;

typedef struct 
{
	NET_DVR_CRUISE_POINT struCruisePoint[32];			//���֧��32��Ѳ����
}NET_DVR_CRUISE_RET, *LPNET_DVR_CRUISE_RET;

//Уʱ�ṹ����
typedef struct
{
	DWORD dwYear;		//��
	DWORD dwMonth;		//��
	DWORD dwDay;		//��
	DWORD dwHour;		//ʱ
	DWORD dwMinute;		//��
	DWORD dwSecond;		//��
}NET_DVR_TIME, *LPNET_DVR_TIME;

//ʱ���(�ӽṹ)
typedef struct
{
	//��ʼʱ��
    BYTE byStartHour;
	BYTE byStartMin;
	//����ʱ��
	BYTE byStopHour;
	BYTE byStopMin;
}NET_DVR_SCHEDTIME, *LPNET_DVR_SCHEDTIME;


//�������쳣����ṹ(�ӽṹ)(�ദʹ��)(9000��չ)
typedef struct
{
	DWORD	dwHandleType;	/*����ʽ,����ʽ��"��"���*/
	/*0x00: ����Ӧ*/
	/*0x01: �������Ͼ���*/
	/*0x02: ��������*/
	/*0x04: �ϴ�����*/
	/*0x08: �����������*/
	/*0x10: ����JPRGץͼ���ϴ�Email*/
	/*0x20: �������ⱨ��������*/
	/*0x40: �������ӵ�ͼ(Ŀǰֻ��PCNVR֧��)*/
	/*0x200: ץͼ���ϴ�FTP*/
	BYTE byRelAlarmOut[MAX_ALARMOUT_V30];  
	//�������������ͨ��,�������������,Ϊ1��ʾ���������
}NET_DVR_HANDLEEXCEPTION_V30, *LPNET_DVR_HANDLEEXCEPTION_V30;

//DVR�豸����
typedef struct
{
	DWORD dwSize;
	BYTE sDVRName[NAME_LEN];     //DVR����
	DWORD dwDVRID;				//DVR ID,����ң���� //V1.4(0-99), V1.5(0-255)
	DWORD dwRecycleRecord;		//�Ƿ�ѭ��¼��,0:����; 1:��
	//���²��ɸ���
	BYTE sSerialNumber[SERIALNO_LEN];  //���к�
	DWORD dwSoftwareVersion;			//����汾��,��16λ�����汾,��16λ�Ǵΰ汾
	DWORD dwSoftwareBuildDate;			//�����������,0xYYYYMMDD
	DWORD dwDSPSoftwareVersion;		    //DSP����汾,��16λ�����汾,��16λ�Ǵΰ汾
	DWORD dwDSPSoftwareBuildDate;		// DSP�����������,0xYYYYMMDD
	DWORD dwPanelVersion;				// ǰ���汾,��16λ�����汾,��16λ�Ǵΰ汾
	DWORD dwHardwareVersion;	// Ӳ���汾,��16λ�����汾,��16λ�Ǵΰ汾
	BYTE byAlarmInPortNum;		//DVR�����������
	BYTE byAlarmOutPortNum;		//DVR�����������
	BYTE byRS232Num;			//DVR 232���ڸ���
	BYTE byRS485Num;			//DVR 485���ڸ���
	BYTE byNetworkPortNum;		//����ڸ���
	BYTE byDiskCtrlNum;			//DVR Ӳ�̿���������
	BYTE byDiskNum;				//DVR Ӳ�̸���
	BYTE byDVRType;				//DVR����, 1:DVR 2:ATM DVR 3:DVS ......
	BYTE byChanNum;				//DVR ͨ������
	BYTE byStartChan;			//��ʼͨ����,����DVS-1,DVR - 1
	BYTE byDecordChans;			//DVR ����·��
	BYTE byVGANum;				//VGA�ڵĸ���
	BYTE byUSBNum;				//USB�ڵĸ���
    BYTE byAuxoutNum;			//���ڵĸ���
    BYTE byAudioNum;			//�����ڵĸ���
    BYTE byIPChanNum;			//�������ͨ����
}NET_DVR_DEVICECFG, *LPNET_DVR_DEVICECFG;

/*
IP��ַ
*/
typedef struct
{		
	char	sIpV4[16];						/* IPv4��ַ */
	BYTE	byIPv6[128];						/* ���� */
}NET_DVR_IPADDR, *LPNET_DVR_IPADDR;

/*
�������ݽṹ(�ӽṹ)(9000��չ)
*/
typedef struct 
{
	NET_DVR_IPADDR	struDVRIP;          					//DVR IP��ַ
	NET_DVR_IPADDR	struDVRIPMask;  //DVR IP��ַ����
	DWORD	dwNetInterface;   								//����ӿ�1-10MBase-T 2-10MBase-Tȫ˫�� 3-100MBase-TX 4-100Mȫ˫�� 5-10M/100M����Ӧ
	WORD	wDVRPort;										//�˿ں�
	WORD	wMTU;											//����MTU���ã�Ĭ��1500��
	BYTE	byMACAddr[MACADDR_LEN];							// �����ַ
	BYTE    byRes[2];              //����
}NET_DVR_ETHERNET_V30, *LPNET_DVR_ETHERNET_V30;

//pppoe�ṹ
typedef struct 
{
	DWORD	dwPPPOE;										//0-������,1-����
	BYTE	sPPPoEUser[NAME_LEN];							//PPPoE�û���
	char	sPPPoEPassword[PASSWD_LEN];						// PPPoE����
	NET_DVR_IPADDR	struPPPoEIP;							//PPPoE IP��ַ
}NET_DVR_PPPOECFG, *LPNET_DVR_PPPOECFG;

//�������ýṹ(9000��չ)
typedef struct
{	
	DWORD dwSize;
	NET_DVR_ETHERNET_V30	struEtherNet[MAX_ETHERNET];		//��̫����
	NET_DVR_IPADDR	struRes1[2];							//����
	NET_DVR_IPADDR	struAlarmHostIpAddr;					//��������IP��ַ
	WORD	wRes2[2];										//����
	WORD	wAlarmHostIpPort;								/* ���������˿ں� */
	BYTE    byUseDhcp;                                      /* �Ƿ�����DHCP 0xff-��Ч 0-������ 1-����*/
	BYTE	byRes3;											//����
	NET_DVR_IPADDR	struDnsServer1IpAddr;					/* ����������1��IP��ַ */
	NET_DVR_IPADDR	struDnsServer2IpAddr;					/* ����������2��IP��ַ */
	BYTE	byIpResolver[MAX_DOMAIN_NAME];					/* IP����������������IP��ַ */
	WORD	wIpResolverPort;								/* IP�����������˿ں� */
	WORD	wHttpPortNo;									/* HTTP�˿ں� */
	NET_DVR_IPADDR	struMulticastIpAddr;					/* �ಥ���ַ */
	NET_DVR_IPADDR	struGatewayIpAddr;						/* ���ص�ַ */
	NET_DVR_PPPOECFG struPPPoE;	
    BYTE    byRes[64];
} NET_DVR_NETCFG_V30, *LPNET_DVR_NETCFG_V30;

//�ƶ����(�ӽṹ)(9000��չ)
typedef struct 
{
	BYTE byMotionScope[64][96];									/*�������,0-96λ,��ʾ64��,����96*64��С���,Ϊ1��ʾ���ƶ��������,0-��ʾ����*/
	BYTE byMotionSensitive;										/*�ƶ����������, 0 - 5,Խ��Խ����,oxff�ر�*/
	BYTE byEnableHandleMotion;									/* �Ƿ����ƶ���� 0���� 1����*/ 
	BYTE byRes;													/* ���� */
	char reservedData;	
	NET_DVR_HANDLEEXCEPTION_V30 struMotionHandleType;			/* ����ʽ */
	NET_DVR_SCHEDTIME struAlarmTime[MAX_DAYS][MAX_TIMESEGMENT_V30]; /*����ʱ��*/
	BYTE byRelRecordChan[MAX_CHANNUM_V30];									/* ����������¼��ͨ��*/
}NET_DVR_MOTION_V30, *LPNET_DVR_MOTION_V30;

//�ڵ�����(�ӽṹ)(9000��չ)  �����С704*576
typedef struct 
{
	DWORD dwEnableHideAlarm;				/* �Ƿ������ڵ����� ,0-��,1-�������� 2-�������� 3-��������*/
	WORD wHideAlarmAreaTopLeftX;			/* �ڵ������x���� */
	WORD wHideAlarmAreaTopLeftY;			/* �ڵ������y���� */
	WORD wHideAlarmAreaWidth;				/* �ڵ�����Ŀ� */
	WORD wHideAlarmAreaHeight;				/*�ڵ�����ĸ�*/
	NET_DVR_HANDLEEXCEPTION_V30 strHideAlarmHandleType;	/* ����ʽ */
	NET_DVR_SCHEDTIME struAlarmTime[MAX_DAYS][MAX_TIMESEGMENT_V30];//����ʱ��
}NET_DVR_HIDEALARM_V30, *LPNET_DVR_HIDEALARM_V30;

//�źŶ�ʧ����(�ӽṹ)(9000��չ)
typedef struct 
{
	BYTE byEnableHandleVILost;	/* �Ƿ����źŶ�ʧ���� */
	NET_DVR_HANDLEEXCEPTION_V30 strVILostHandleType;	/* ����ʽ */
	NET_DVR_SCHEDTIME struAlarmTime[MAX_DAYS][MAX_TIMESEGMENT_V30];//����ʱ��
}NET_DVR_VILOST_V30, *LPNET_DVR_VILOST_V30;

//�ڵ�����(�ӽṹ)
typedef struct 
{
	WORD wHideAreaTopLeftX;				/* �ڵ������x���� */
	WORD wHideAreaTopLeftY;				/* �ڵ������y���� */
	WORD wHideAreaWidth;				/* �ڵ�����Ŀ� */
	WORD wHideAreaHeight;				/*�ڵ�����ĸ�*/
}NET_DVR_SHELTER, *LPNET_DVR_SHELTER;

typedef struct
{
	BYTE byBrightness;  	/*����,0-255*/
	BYTE byContrast;    	/*�Աȶ�,0-255*/	
	BYTE bySaturation;  	/*���Ͷ�,0-255*/
	BYTE byHue;    			/*ɫ��,0-255*/
}NET_DVR_COLOR, *LPNET_DVR_COLOR;

//ͨ��ͼ��ṹ(9000��չ)
typedef struct
{
	DWORD dwSize;
	BYTE  sChanName[NAME_LEN];
	DWORD dwVideoFormat;	/* ֻ�� ��Ƶ��ʽ 1-NTSC 2-PAL*/
	BYTE  byReservedData[64];/*����*/
	DWORD dwShowChanName; // Ԥ����ͼ�����Ƿ���ʾͨ������,0-����ʾ,1-��ʾ �����С704*576
	WORD wShowNameTopLeftX;				/* ͨ��������ʾλ�õ�x���� */
	WORD wShowNameTopLeftY;				/* ͨ��������ʾλ�õ�y���� */
	//��Ƶ�źŶ�ʧ����
	NET_DVR_VILOST_V30 struVILost;
	NET_DVR_VILOST_V30 struRes;		/*����*/
	//	BYTE byRes1[328];
	//�ƶ����
	NET_DVR_MOTION_V30 struMotion;
	//�ڵ�����
	NET_DVR_HIDEALARM_V30 struHideAlarm;
	//�ڵ�  �����С704*576
	DWORD dwEnableHide;		/* �Ƿ������ڵ� ,0-��,1-��*/
	NET_DVR_SHELTER struShelter[MAX_SHELTERNUM];
	//OSD
	DWORD dwShowOsd;// Ԥ����ͼ�����Ƿ���ʾOSD,0-����ʾ,1-��ʾ �����С704*576
	WORD wOSDTopLeftX;				/* OSD��x���� */
	WORD wOSDTopLeftY;				/* OSD��y���� */
	BYTE byOSDType;					/* OSD����(��Ҫ�������ո�ʽ) */
	/* 0: XXXX-XX-XX ������ */
	/* 1: XX-XX-XXXX ������ */
	/* 2: XXXX��XX��XX�� */
	/* 3: XX��XX��XXXX�� */
	/* 4: XX-XX-XXXX ������*/
	/* 5: XX��XX��XXXX�� */
	/*6: xx/xx/xxxx(��/��/��) */
	/*7: xxxx/xx/xx(��/��/��) */
	/*8: xx/xx/xxxx(��/��/��)*/
	BYTE byDispWeek;				/* �Ƿ���ʾ���� */
	BYTE byOSDAttrib;				/* OSD����:͸������˸ */
	/* 1: ͸��,��˸ */
	/* 2: ͸��,����˸ */
	/* 3: ��˸,��͸�� */
	/* 4: ��͸��,����˸ */
	BYTE byHourOSDType;				/* OSDСʱ��:0-24Сʱ��,1-12Сʱ�� */
	BYTE byFontSize;//�����С��16*16(��)/8*16(Ӣ)��1-32*32(��)/16*32(Ӣ)��2-64*64(��)/32*64(Ӣ)  3-48*48(��)/24*48(Ӣ) 0xff-����Ӧ(adaptive)
	BYTE byRes[63];
}NET_DVR_PICCFG_V30, *LPNET_DVR_PICCFG_V30;


//����ѹ������(�ӽṹ)(9000��չ)
typedef struct 
{
	BYTE byStreamType;		//�������� 0-��Ƶ��, 1-������, ��ʾ�¼�ѹ������ʱ���λ��ʾ�Ƿ�����ѹ������
	/*�ֱ���0-DCIF                      1-CIF,                     2-QCIF,                 3-4CIF,             
	4-2CIF                      5��������,                 6-QVGA(320*240),        7-QQVGA(160*120),  
	12-384*288                  13-576*576,                   
	16-VGA��640*480��,          17-UXGA��1600*1200��,      18-SVGA(800*600),       19-HD720p(1280*720��,   
	20-XVGA,                    21-HD900p,                 23-1536*1536,              
	24-1920*1920,               27-HD1080i,                   
	28-2560*1920,               29-1600*304,               30-2048*1536,           31-2448*2048,                
	32-2448*1200,               33-2448*800,               34-XGA��1024*768����    35-SXGA��1280*1024��,         
	36-WD1(960*576/960*480),    37-1080i,                  38-WSXGA(1440*900),     39-HD_F(1920*1080/1280*720),  
	40-HD_H(1920*540/1280*360), 41-HD_Q(960*540/630*360),  42-2336*1744,           43-1920*1456,                 
	44-2592*2048,               45-3296*2472,              46-1376*768,            47-1366*768,                 
	48-1360*768,                49-WSXGA+,                 50-720*720,             51-1280*1280,                 
	52-2048*768,                53-2048*2048,              54-2560*2048,           55-3072*2048,
	56-2304*1296                57-WXGA(1280*800),         58-1600*600
	0xff-Auto(ʹ�õ�ǰ�����ֱ���)
	*/
	BYTE byResolution;  	
	BYTE byBitrateType;		//�������� 0:������, 1:������,0xfe:�Զ�����Դһ��
	BYTE byPicQuality;		//ͼ������ 0-��� 1-�κ� 2-�Ϻ� 3-һ�� 4-�ϲ� 5-��,�Զ�����Դһ��
	/*��Ƶ����:0-������1-16K(����)��2-32K��3-48k��4-64K��5-80K��6-96K��7-128K��8-160k��9-192K��10-224K��
	11-256K��12-320K��13-384K��14-448K��15-512K��16-640K��17-768K��18-896K��19-1024K��20-1280K��21-1536K��22-1792K��23-2048K��
	24-3072K��25-4096K��26-8192K��27-16384K�����λ(31λ)�ó�1��ʾ���Զ���������0��30λ��ʾ����ֵ����Сֵ16k,0xfffffffe���Զ�����Դһ��*/
	DWORD dwVideoBitrate; 	 
	DWORD dwVideoFrameRate;	//֡�� 0-ȫ��; 1-1/16; 2-1/8; 3-1/4; 4-1/2; 5-1; 6-2; 7-4; 8-6; 9-8; 10-10; 11-12; 12-16; 13-20; V2.0�汾���¼�14-15; 15-18; 16-22;
	//17-25��18-30��19-35��20-40��21-45��22-50��23-55��24-60,0xfffffffe-�Զ�����Դһ��
	WORD  wIntervalFrameI;  //I֡���,0xfffe �Զ�����Դһ��
	BYTE  byIntervalBPFrame;//0-BBP֡; 1-BP֡; 2-��P֡(2006-08-11 ���ӵ�P֡�����ýӿڣ����Ը���ʵʱ����ʱ����)��0xfe-�Զ�����Դһ��
	BYTE  byres1;        //����
	BYTE  byVideoEncType;   //��Ƶ�������� 0-˽��264��1-��׼h264��2-��׼mpeg4��7-M-JPEG��8-MPEG2��0xfe-�Զ�����Դһ�£���0xff-��Ч 
	BYTE  byAudioEncType;   //��Ƶ�������� 0-OggVorbis;1-G711_U;2-G711_A;5-MP2L2;6-G276;7-AAC;0xff-��Ч
	BYTE  byVideoEncComplexity; //��Ƶ���븴�Ӷȣ�0-�ͣ�1-�У�2��,0xfe:�Զ�����Դһ��
	BYTE  byEnableSvc; //0 - ������SVC���ܣ�1- ����SVC����
	BYTE  byFormatType; //��װ���ͣ�1-������2-RTP��װ��3-PS��װ��4-TS��װ��5-˽�У�6-FLV��7-ASF��8-3GP,9-RTP+PS�����꣺GB28181����0xff-��Ч
	BYTE  byAudioBitRate; //��Ƶ����0-Ĭ�ϣ�1-8Kbps, 2- 16Kbps, 3-32Kbps��4-64Kbps��5-128Kbps��6-192Kbps��(IPC5.1.0Ĭ��4-64Kbps)
	BYTE  byres[6];
}NET_DVR_COMPRESSION_INFO_V30, *LPNET_DVR_COMPRESSION_INFO_V30;

//ͨ��ѹ������(9000��չ)
typedef struct 
{
	DWORD dwSize;
	NET_DVR_COMPRESSION_INFO_V30 struNormHighRecordPara;    //¼�� ��Ӧ8000����ͨ
	NET_DVR_COMPRESSION_INFO_V30 struRes;//���� char reserveData[28];
    NET_DVR_COMPRESSION_INFO_V30 struEventRecordPara;       //�¼�����ѹ������
	NET_DVR_COMPRESSION_INFO_V30 struNetPara;               //����(������)
}NET_DVR_COMPRESSIONCFG_V30, *LPNET_DVR_COMPRESSIONCFG_V30;

//ipc�����豸��Ϣ��չ��֧��ip�豸���������
typedef struct tagNET_DVR_IPDEVINFO_V31
{
    BYTE byEnable;				    //��IP�豸�Ƿ���Ч
	BYTE byProType;					//Э�����ͣ�0-˽��Э�飬1-����Э�飬2-����
    BYTE byEnableQuickAdd;        // 0 ��֧�ֿ������  1 ʹ�ÿ������ 
    // ���������Ҫ�豸IP��Э�����ͣ�������Ϣ���豸Ĭ��ָ��
    BYTE byRes1;					//�����ֶΣ���0
    BYTE sUserName[NAME_LEN];		//�û���
    BYTE sPassword[PASSWD_LEN];	    //����
    BYTE byDomain[MAX_DOMAIN_NAME];	//�豸����
    NET_DVR_IPADDR struIP;			//IP��ַ
    WORD wDVRPort;			 	    // �˿ں�
    BYTE byRes2[34];				//�����ֶΣ���0
}NET_DVR_IPDEVINFO_V31, *LPNET_DVR_IPDEVINFO_V31;

/* IPͨ��ƥ����� */
typedef struct 
{
	BYTE byEnable;					/* ��ͨ���Ƿ����� */
	BYTE byIPID;					//IP�豸ID��8λ�����豸IDΪ0ʱ��ʾͨ��������
	BYTE byChannel;					/* ͨ���� */
	BYTE byIPIDHigh;                // IP�豸ID�ĸ�8λ
	BYTE byTransProtocol;		        //����Э������0-TCP/auto(�������豸����)��1-UDP 2-�ಥ 3-��TCP 4-auto
	BYTE byres[31];					/* ���� */
} NET_DVR_IPCHANINFO, *LPNET_DVR_IPCHANINFO;

/* ��չIP�������ýṹ */
typedef struct tagNET_DVR_IPPARACFG_V31
{
    DWORD dwSize;			                            /* �ṹ��С */
    NET_DVR_IPDEVINFO_V31  struIPDevInfo[MAX_IP_DEVICE];    /* IP�豸 */
    BYTE byAnalogChanEnable[MAX_ANALOG_CHANNUM];        /* ģ��ͨ���Ƿ����ã��ӵ͵��߱�ʾ1-32ͨ����0��ʾ��Ч 1��Ч */
    NET_DVR_IPCHANINFO struIPChanInfo[MAX_IP_CHANNEL];	/* IPͨ�� */    
}NET_DVR_IPPARACFG_V31, *LPNET_DVR_IPPARACFG_V31;

//¼���ļ�����(9000)
typedef struct 
{
    char sFileName[100];//�ļ���
    NET_DVR_TIME struStartTime;//�ļ��Ŀ�ʼʱ��
    NET_DVR_TIME struStopTime;//�ļ��Ľ���ʱ��
    DWORD dwFileSize;//�ļ��Ĵ�С
    char sCardNum[32];
    BYTE byLocked;//9000�豸֧��,1��ʾ���ļ��Ѿ�������,0��ʾ�������ļ�
	BYTE byFileType;  //�ļ�����:0����ʱ¼��,1-�ƶ���� ��2������������
	//3-����|�ƶ���� 4-����&�ƶ���� 5-����� 6-�ֶ�¼��
    BYTE byRes[2];
}NET_DVR_FINDDATA_V30, *LPNET_DVR_FINDDATA_V30;

//¼���ļ����������ṹ
typedef struct 
{
    LONG lChannel;//ͨ����
    DWORD dwFileType;//¼���ļ�����0xff��ȫ����0����ʱ¼��,1-�ƶ���� ��2������������
	//3-����|�ƶ���� 4-����&�ƶ���� 5-����� 6-�ֶ�¼��
    DWORD dwIsLocked;//�Ƿ����� 0-�����ļ�,1-�����ļ�, 0xff��ʾ�����ļ�
    DWORD dwUseCardNo;//�Ƿ�ʹ�ÿ���
    BYTE sCardNumber[32];//����
    NET_DVR_TIME struStartTime;//��ʼʱ��
    NET_DVR_TIME struStopTime;//����ʱ��
}NET_DVR_FILECOND, *LPNET_DVR_FILECOND;
	
//�����豸��Ϣ
typedef struct
{   
    BYTE byUserIDValid;                 /* userid�Ƿ���Ч 0-��Ч��1-��Ч */
    BYTE bySerialValid;                 /* ���к��Ƿ���Ч 0-��Ч��1-��Ч */
    BYTE byVersionValid;                /* �汾���Ƿ���Ч 0-��Ч��1-��Ч */
    BYTE byDeviceNameValid;             /* �豸�����Ƿ���Ч 0-��Ч��1-��Ч */
    BYTE byMacAddrValid;                /* MAC��ַ�Ƿ���Ч 0-��Ч��1-��Ч */    
    BYTE byLinkPortValid;               /* login�˿��Ƿ���Ч 0-��Ч��1-��Ч */
    BYTE byDeviceIPValid;               /* �豸IP�Ƿ���Ч 0-��Ч��1-��Ч */
    BYTE bySocketIPValid;               /* socket ip�Ƿ���Ч 0-��Ч��1-��Ч */
    LONG lUserID;                       /* NET_DVR_Login()����ֵ, ����ʱ��Ч */
    BYTE sSerialNumber[SERIALNO_LEN];	/* ���к� */
    DWORD dwDeviceVersion;			    /* �汾��Ϣ ��16λ��ʾ���汾����16λ��ʾ�ΰ汾*/
    char sDeviceName[NAME_LEN];		    /* �豸���� */
    BYTE byMacAddr[MACADDR_LEN];		/* MAC��ַ */    
    WORD wLinkPort;                     /* link port */
    char sDeviceIP[128];    			/* IP��ַ */
    char sSocketIP[128];    			/* ���������ϴ�ʱ��socket IP��ַ */
    BYTE byIpProtocol;                  /* IpЭ�� 0-IPV4, 1-IPV6 */
    BYTE byRes2[11];
}NET_DVR_ALARMER, *LPNET_DVR_ALARMER;

//�������״̬(9000��չ)
typedef struct 
{
	BYTE Output[MAX_ALARMOUT_V30];
}NET_DVR_ALARMOUTSTATUS_V30, *LPNET_DVR_ALARMOUTSTATUS_V30;	

//�ϴ�������Ϣ(9000��չ)
typedef struct 
{
	DWORD dwAlarmType;/*0-�ź�������,1-Ӳ����,2-�źŶ�ʧ,3���ƶ����,4��Ӳ��δ��ʽ��,5-��дӲ�̳���,6-�ڵ�����,7-��ʽ��ƥ��, 8-�Ƿ�����, 9-��Ƶ�ź��쳣��
	10-¼���쳣 11- ���ܳ����仯  12-�����쳣 */
	DWORD dwAlarmInputNumber;/*��������˿�*/
	BYTE byAlarmOutputNumber[MAX_ALARMOUT_V30];/*����������˿ڣ�Ϊ1��ʾ��Ӧ���*/
	BYTE byAlarmRelateChannel[MAX_CHANNUM_V30];/*������¼��ͨ����Ϊ1��ʾ��Ӧ¼��, dwAlarmRelateChannel[0]��Ӧ��1��ͨ��*/
	BYTE byChannel[MAX_CHANNUM_V30];/*dwAlarmTypeΪ2��3,6��9��10ʱ����ʾ�ĸ�ͨ����dwChannel[0]��Ӧ��1��ͨ��*/
	BYTE byDiskNumber[MAX_DISKNUM_V30];/*dwAlarmTypeΪ1,4,5ʱ,��ʾ�ĸ�Ӳ��, dwDiskNumber[0]��Ӧ��1��Ӳ��*/
}NET_DVR_ALARMINFO_V30, *LPNET_DVR_ALARMINFO_V30;

typedef struct 
{
	DWORD dwAlarmType;/*0-�ź�������,1-Ӳ����,2-�źŶ�ʧ,3���ƶ����,4��Ӳ��δ��ʽ��,5-��дӲ�̳���,6-�ڵ�����,7-��ʽ��ƥ��, 8-�Ƿ�����, 9-��Ƶ�ź��쳣��10-¼���쳣 11- ���ܳ����仯*/
	DWORD dwAlarmInputNumber;/*��������˿�*/
	DWORD dwAlarmOutputNumber[MAX_ALARMOUT];/*����������˿ڣ���һλΪ1��ʾ��Ӧ��һ�����*/
	DWORD dwAlarmRelateChannel[MAX_CHANNUM];/*������¼��ͨ������һλΪ1��ʾ��Ӧ��һ·¼��, dwAlarmRelateChannel[0]��Ӧ��1��ͨ��*/
	DWORD dwChannel[MAX_CHANNUM];/*dwAlarmTypeΪ2��3,6,9,10ʱ����ʾ�ĸ�ͨ����dwChannel[0]λ��Ӧ��1��ͨ��*/
	DWORD dwDiskNumber[MAX_DISKNUM];/*dwAlarmTypeΪ1,4,5ʱ,��ʾ�ĸ�Ӳ��, dwDiskNumber[0]λ��Ӧ��1��Ӳ��*/
}NET_DVR_ALARMINFO, *LPNET_DVR_ALARMINFO;

//��̨����ѡ��Ŵ���С(˽�� ����ר��)
typedef struct 
{
	int xTop;     //������ʼ���x����
	int yTop;     //����������y����
	int xBottom;  //����������x����
	int yBottom;  //����������y����
	int bCounter; //����
}NET_DVR_POINT_FRAME, *LPNET_DVR_POINT_FRAME;

//ͼƬ����
typedef struct 
{
/*	ע�⣺��ͼ��ѹ���ֱ���ΪVGAʱ��֧��0=CIF, 1=QCIF, 2=D1ץͼ��
	���ֱ���Ϊ3=UXGA(1600x1200), 4=SVGA(800x600), 5=HD720p(1280x720),6=VGA,7=XVGA, 8=HD900p
	��֧�ֵ�ǰ�ֱ��ʵ�ץͼ
*/
	WORD	wPicSize;				/* 0-CIF��1-QCIF��2-D1��3-UXGA(1600x1200)��
									4-SVGA(800x600)��5-HD720p(1280x720)��6-VGA��7-XVGA��8-HD900p��
									9-HD1080��10-2560*1920��11-1600*304��12-2048*1536��
									13-2448*2048,14-2448*1200��15-2448*800��
									16-XGA(1024*768)��17-SXGA(1280*1024),18-WD1(960*576/960*480),19-1080i*/
	WORD	wPicQuality;			/* ͼƬ����ϵ�� 0-��� 1-�Ϻ� 2-һ�� */
}NET_DVR_JPEGPARA, *LPNET_DVR_JPEGPARA;

typedef struct
{
	BYTE    byAudioEncType;
	BYTE    byres[7];
}NET_DVR_COMPRESSION_AUDIO, *LPNET_DVR_COMPRESSION_AUDIO;

typedef struct
{
	BYTE     byIPID;
	BYTE     byAlarmOut;
	BYTE     byRes[18];
}NET_DVR_IPALARMOUTINFO, *LPNET_DVR_IPALARMOUTINFO;

typedef struct
{
	DWORD                      dwSize;
	NET_DVR_IPALARMOUTINFO     struIPAlarmOutInfo[MAX_IP_ALARMOUT];
}NET_DVR_IPALARMOUTCFG, *LPNET_DVR_IPALARMOUTCFG;

#define DESC_LEN                16      /* ��̨�����ַ������� */
//��̨Э���ṹ����
typedef struct
{ 
	DWORD dwType;               /*����������ֵ*/    
	BYTE  byDescribe[DESC_LEN]; /*������������������8000�е�һ��*/    
}NET_DVR_PTZ_PROTOCOL;

#define PTZ_PROTOCOL_NUM        200     /* 9000���֧�ֵ���̨Э���� */
typedef struct
{    
	DWORD   dwSize;    
	NET_DVR_PTZ_PROTOCOL struPtz[PTZ_PROTOCOL_NUM];/*���200��PTZЭ��*/    
	DWORD   dwPtzNum;           /*��Ч��ptzЭ����Ŀ����0��ʼ(������ʱ��1)*/
	BYTE    byRes[8];
}NET_DVR_PTZCFG, *LPNET_DVR_PTZCFG;

typedef struct tagNET_DVR_SDKLOCAL_CFG
{
	BYTE	byEnableAbilityParse;	//ʹ��������������,0-��ʹ��,1-ʹ��,Ĭ�ϲ�ʹ��
	BYTE    byVoiceComMode;          //�Խ�ģʽ��0-ʹ�öԽ��⣨Ĭ�ϣ���1-ʹ��windows apiģʽ	
	BYTE	byRes[382];
	BYTE	byProtectKey[128];	//Ĭ������Ϊ0
}NET_DVR_SDKLOCAL_CFG, *LPNET_DVR_SDKLOCAL_CFG;

//Ӳ��״̬
typedef struct 
{
	DWORD dwVolume;//Ӳ�̵�����
	DWORD dwFreeSpace;//Ӳ�̵�ʣ��ռ�
	DWORD dwHardDiskStatic; //Ӳ�̵�״̬,��λ:1-����,2-������,3-����Ӳ�̳���,4-δ��ʽ��, 5-δ����״̬(����Ӳ��),6-Ӳ�����ڸ�ʽ��
}NET_DVR_DISKSTATE, *LPNET_DVR_DISKSTATE;
//ͨ��״̬(9000��չ)
typedef struct 
{
	BYTE byRecordStatic; //ͨ���Ƿ���¼��,0-��¼��,1-¼��
	BYTE bySignalStatic; //���ӵ��ź�״̬,0-����,1-�źŶ�ʧ
	BYTE byHardwareStatic;//ͨ��Ӳ��״̬,0-����,1-�쳣,����DSP����
	BYTE byRes1;		//����
	DWORD dwBitRate;//ʵ������
	DWORD dwLinkNum;//�ͻ������ӵĸ���
	NET_DVR_IPADDR struClientIP[MAX_LINK];//�ͻ��˵�IP��ַ
	DWORD dwIPLinkNum;//�����ͨ��ΪIP���룬��ô��ʾIP���뵱ǰ��������
	BYTE byExceedMaxLink;		// �Ƿ񳬳��˵�·6·������ 0 - δ����, 1-����
	BYTE byRes[7];        // �����ֽ�
	DWORD dwChannelNo;    //��ǰ��ͨ���ţ�0xffffffff��ʾ��Ч
}NET_DVR_CHANNELSTATE_V30, *LPNET_DVR_CHANNELSTATE_V30;
//DVR����״̬(9000��չ)
typedef struct 
{
	DWORD dwDeviceStatic; 	//�豸��״̬,0-����,1-CPUռ����̫��,����85%,2-Ӳ������,���紮������
	NET_DVR_DISKSTATE  struHardDiskStatic[MAX_DISKNUM_V30];
	NET_DVR_CHANNELSTATE_V30 struChanStatic[MAX_CHANNUM_V30];//ͨ����״̬
	BYTE  byAlarmInStatic[MAX_ALARMIN_V30]; //�����˿ڵ�״̬,0-û�б���,1-�б���
	BYTE  byAlarmOutStatic[MAX_ALARMOUT_V30]; //��������˿ڵ�״̬,0-û�����,1-�б������
	DWORD  dwLocalDisplay;//������ʾ״̬,0-����,1-������
	BYTE  byAudioChanStatus[MAX_AUDIO_V30];//��ʾ����ͨ����״̬ 0-δʹ�ã�1-ʹ����, 0xff��Ч
	BYTE  byRes[10];
}NET_DVR_WORKSTATE_V30, *LPNET_DVR_WORKSTATE_V30;

typedef struct
{
	DWORD  dwEnabled;               //�ö˿��Ƿ�ʹ��ӳ��
	WORD   wInternalPort;           //ӳ��ǰ�Ķ˿�
	WORD   wExternalPort;           //ӳ���Ķ˿�
	DWORD  dwStatus;				 /*�˿�ӳ��״̬
									 0 δ��Ч
									 1 δ��Ч��ӳ��Դ�˿���Ŀ�Ķ˿���һ��
									 2 δ��Ч:  ӳ��˿ں��ѱ�ʹ��
									 3 ��Ч
									 */
	NET_DVR_IPADDR	struNatExternalIp;       //ӳ�����ⲿ��ַ
	NET_DVR_IPADDR	struNatInternalIp;       //NAT·����LAN IP��ַ
	BYTE   byRes[16];               //����
}NET_DVR_UPNP_PORT_STATE, *LPNET_DVR_UPNP_PORT_STATE;

#define UPNP_PORT_NUM			12	  //upnp�˿�ӳ��˿���Ŀ
typedef struct
{
	NET_DVR_UPNP_PORT_STATE strUpnpPort[UPNP_PORT_NUM];     //�˿�ӳ��״̬,����0 web server�˿� ����1 ����˿� ����2 rtsp�˿�
	BYTE   byRes[200];              //����
}NET_DVR_UPNP_NAT_STATE, *LPNET_DVR_UPNP_NAT_STATE;

typedef enum _COMPRESSION_ABILITY_TYPE_
{
	COMPRESSION_STREAM_ABILITY = 0, //����ѹ������
	MAIN_RESOLUTION_ABILITY = 1,	//������ѹ���ֱ���
	SUB_RESOLUTION_ABILITY  = 2,	//������ѹ���ֱ���
	EVENT_RESOLUTION_ABILITY =  3,  //�¼�ѹ�������ֱ���
	FRAME_ABILITY = 4,				//֡������
	BITRATE_TYPE_ABILITY = 5,		//λ����������
	BITRATE_ABILITY = 6,			//λ������
	THIRD_RESOLUTION_ABILITY = 7,   //������ѹ���ֱ���
	STREAM_TYPE_ABILITY = 8,        //��������
	PIC_QUALITY_ABILITY = 9,         //ͼ������
	INTERVAL_BPFRAME_ABILITY = 10,  //BP֡���
	VIDEO_ENC_ABILITY = 11,           //��Ƶ��������
	AUDIO_ENC_ABILITY = 12,           //��Ƶ��������
	VIDEO_ENC_COMPLEXITY_ABILITY = 13, //��Ƶ���븴�Ӷ�����
	FORMAT_ABILITY = 14, //��װ��ʽ����
}COMPRESSION_ABILITY_TYPE;

typedef struct tagNET_DVR_WIFIETHERNET
{	
	char sIpAddress[16];				/*IP��ַ*/
	char sIpMask[16];					/*����*/	
	BYTE	byMACAddr[MACADDR_LEN];		/*�����ַ��ֻ������ʾ*/
	BYTE	bRes[2];
	DWORD	dwEnableDhcp;				/*�Ƿ�����dhcp  0������ 1����*/
	DWORD	dwAutoDns;					/*�������dhcp�Ƿ��Զ���ȡdns,0���Զ���ȡ 1�Զ���ȡ�����������������dhcpĿǰ�Զ���ȡdns*/	
	char sFirstDns[16];						 /*��һ��dns����*/
	char sSecondDns[16];					 /*�ڶ���dns����*/
	char sGatewayIpAddr[16]; 				/* ���ص�ַ*/
	BYTE   bRes2[8];
}NET_DVR_WIFIETHERNET,*LPNET_DVR_WIFIETHERNET;
#define IW_ESSID_MAX_SIZE						 32
#define WIFI_WEP_MAX_KEY_COUNT					 4
#define WIFI_WEP_MAX_KEY_LENGTH					 33
#define WIFI_WPA_PSK_MAX_KEY_LENGTH				 63
#define WIFI_WPA_PSK_MIN_KEY_LENGTH				 8
#define WIFI_MAX_AP_COUNT						 20
typedef struct tagNET_DVR_WIFI_CFG_EX
{
	NET_DVR_WIFIETHERNET struEtherNet;        /*wifi����*/
	char sEssid[IW_ESSID_MAX_SIZE];	 /*SSID*/
	DWORD dwMode;      /* 0 mange ģʽ;1 ad-hocģʽ���μ�*/
	DWORD dwSecurity; /*0-������;1-WEP����;2-WPA-personal; 3-WPA-enterprise;4-WPA2-personal;5-WPA2-enterprise */
	union 
	{
		struct 
		{
			DWORD dwAuthentication;/*0 -����ʽ 1-����ʽ*/
			DWORD dwKeyLength;/* 0 -64λ��1- 128λ��2-152λ*/
			DWORD dwKeyType;/*0 16����;1 ASCI */
			DWORD dwActive;/*0 ������0---3��ʾ����һ����Կ*/
			char sKeyInfo[WIFI_WEP_MAX_KEY_COUNT][WIFI_WEP_MAX_KEY_LENGTH];
		}wep;
		struct 
		{
			DWORD dwKeyLength;/*8-63��ASCII�ַ�*/
			char sKeyInfo[WIFI_WPA_PSK_MAX_KEY_LENGTH];
			BYTE byEncryptType;  /*WPA/WPA2ģʽ�¼�������,0-AES, 1-TKIP*/
		}wpa_psk;
		struct 
		{
			BYTE byEncryptType;  /*��������,0-AES, 1-TKIP*/
			BYTE byAuthType; //��֤���ͣ�0-EAP_TTLS,1-EAP_PEAP,2-EAP_TLS
			BYTE byRes[2];
			union
			{
				struct 
				{
					BYTE byEapolVersion; //EAPOL�汾��0-�汾1��1-�汾2
					BYTE byAuthType; //�ڲ���֤��ʽ��0-PAP��1-MSCHAPV2
					BYTE byRes1[2];
					BYTE byAnonyIdentity [NAME_LEN]; //�������
					BYTE byUserName[NAME_LEN]; //�û���
					BYTE byPassword[NAME_LEN]; //����
					BYTE byRes[44];
				}EAP_TTLS; //WPA-enterprise/WPA2-enterprisģʽ����
				struct 
				{
					BYTE byEapolVersion; //EAPOL�汾��0-�汾1��1-�汾2
					BYTE byAuthType; //�ڲ���֤��ʽ��0-GTC��1-MD5��2-MSCHAPV2
					BYTE byPeapVersion; //PEAP�汾��0-�汾0��1-�汾1
					BYTE byPeapLabel; //PEAP��ǩ��0-�ϱ�ǩ��1-�±�ǩ
					BYTE byAnonyIdentity[NAME_LEN]; //�������
					BYTE byUserName[NAME_LEN]; //�û���
					BYTE byPassword[NAME_LEN]; //����
					BYTE byRes[44]; 
				}EAP_PEAP; //WPA-enterprise/WPA2-enterprisģʽ����
				struct 
				{
					BYTE byEapolVersion; //EAPOL�汾��0-�汾1��1-�汾2
					BYTE byRes1[3]; 
					BYTE byIdentity[NAME_LEN]; //���
					BYTE byPrivateKeyPswd[NAME_LEN]; //˽Կ����
					BYTE byRes[76]; 
				}EAP_TLS; 
			}auth_param;
		}wpa_wpa2; //WPA-enterprise/WPA2-enterprisģʽ����
	}key;	
}NET_DVR_WIFI_CFG_EX,*LPNET_DVR_WIFI_CFG_EX;

typedef struct tagNET_DVR_AP_INFO
{
	char  sSsid[IW_ESSID_MAX_SIZE];
	DWORD  dwMode;						/* 0 mange ģʽ;1 ad-hocģʽ���μ�NICMODE */
	DWORD  dwSecurity;           /*0 �����ܣ�1 wep���ܣ�2 wpa-psk;3 wpa-Enterprise;4-WPA2_PSK�μ�WIFISECURITY*/
	DWORD  dwChannel;            /*1-11��ʾ11��ͨ��*/
	DWORD  dwSignalStrength;    /*0-100�ź���������Ϊ��ǿ*/
	DWORD  dwSpeed;               /*����,��λ��0.01mbps*/
}NET_DVR_AP_INFO,*LPNET_DVR_AP_INFO;

typedef struct tagNET_DVR_AP_INFO_LIST
{
	DWORD dwSize;
	DWORD dwCount;        /*����AP������������20*/
	NET_DVR_AP_INFO struApInfo[WIFI_MAX_AP_COUNT];
}NET_DVR_AP_INFO_LIST,*LPNET_DVR_AP_INFO_LIST;

#define DESC_LEN_32          32   //�����ֳ���
#define MAX_NODE_NUM         256  //�ڵ����

typedef struct tagNET_DVR_DESC_NODE
{ 
	int   iValue;           
	BYTE  byDescribe[DESC_LEN_32]; //�����ֶ� 
	DWORD dwFreeSpace;           //��ȡ�����б�ר��,��λΪM
	BYTE  byRes[12];			  //����  
}NET_DVR_DESC_NODE, *LPNET_DVR_DESC_NODE;
//�����б�
typedef struct tagNET_DVR_ABILITY_LIST
{ 
	DWORD     dwAbilityType;	//�������� COMPRESSION_ABILITY_TYPE
	BYTE      byRes[32];        //�����ֽ�
	DWORD     dwNodeNum;		//����������
	NET_DVR_DESC_NODE  struDescNode[MAX_NODE_NUM];  //��������  
}NET_DVR_ABILITY_LIST, *LPNET_DVR_ABILITY_LIST;

#define MAX_ABILITYTYPE_NUM  12   //���������
// ѹ�����������б�
typedef struct tagNET_DVR_COMPRESSIONCFG_ABILITY
{ 
	DWORD     dwSize;            //�ṹ����
	DWORD     dwAbilityNum;		//�������͸���
	NET_DVR_ABILITY_LIST struAbilityNode[MAX_ABILITYTYPE_NUM]; //��������  
}NET_DVR_COMPRESSIONCFG_ABILITY, *LPNET_DVR_COMPRESSIONCFG_ABILITY;

//���������������(9000��չ)
typedef struct 
{
	DWORD dwSize;
	BYTE sAlarmInName[NAME_LEN];	/* ���� */
	BYTE byAlarmType;	            //����������,0������,1������
	BYTE byAlarmInHandle;	        /* �Ƿ��� 0-������ 1-����*/
	BYTE byChannel;                 // �������봥������ʶ��ͨ��
	BYTE byRes1[1];			
	NET_DVR_HANDLEEXCEPTION_V30 struAlarmHandleType;	/* ����ʽ */
	NET_DVR_SCHEDTIME struAlarmTime[MAX_DAYS][MAX_TIMESEGMENT_V30];//����ʱ��
	BYTE byRelRecordChan[MAX_CHANNUM_V30]; //����������¼��ͨ��,Ϊ1��ʾ������ͨ��
	BYTE byEnablePreset[MAX_CHANNUM_V30];		/* �Ƿ����Ԥ�õ� 0-��,1-��*/
	BYTE byPresetNo[MAX_CHANNUM_V30];			/* ���õ���̨Ԥ�õ����,һ������������Ե��ö��ͨ������̨Ԥ�õ�, 0xff��ʾ������Ԥ�õ㡣*/
	BYTE byRes2[192];					/*����*/
	BYTE byEnableCruise[MAX_CHANNUM_V30];		/* �Ƿ����Ѳ�� 0-��,1-��*/
	BYTE byCruiseNo[MAX_CHANNUM_V30];			/* Ѳ�� */
	BYTE byEnablePtzTrack[MAX_CHANNUM_V30];		/* �Ƿ���ù켣 0-��,1-��*/
	BYTE byPTZTrack[MAX_CHANNUM_V30];			/* ���õ���̨�Ĺ켣��� */
	BYTE byRes3[16];
}NET_DVR_ALARMINCFG_V30, *LPNET_DVR_ALARMINCFG_V30;

//DVR�������(9000��չ)
typedef struct 
{
	DWORD dwSize;
	BYTE sAlarmOutName[NAME_LEN];	/* ���� */
	DWORD dwAlarmOutDelay;	/* �������ʱ��(-1Ϊ���ޣ��ֶ��ر�) */
	//0-5��,1-10��,2-30��,3-1����,4-2����,5-5����,6-10����,7-�ֶ�
	NET_DVR_SCHEDTIME struAlarmOutTime[MAX_DAYS][MAX_TIMESEGMENT_V30];/* �����������ʱ��� */
	BYTE byRes[16];
}NET_DVR_ALARMOUTCFG_V30, *LPNET_DVR_ALARMOUTCFG_V30;

//ͨ��������(��̨)��������(9000��չ)
typedef struct 
{
	DWORD dwSize;
	DWORD dwBaudRate;//������(bps)��0��50��1��75��2��110��3��150��4��300��5��600��6��1200��7��2400��8��4800��9��9600��10��19200�� 11��38400��12��57600��13��76800��14��115.2k;
	BYTE byDataBit;// �����м�λ 0��5λ��1��6λ��2��7λ��3��8λ;
	BYTE byStopBit;// ֹͣλ 0��1λ��1��2λ;
	BYTE byParity;// У�� 0����У�飬1����У�飬2��żУ��;
	BYTE byFlowcontrol;// 0���ޣ�1��������,2-Ӳ����
	WORD wDecoderType;//����������, ��0��ʼ����ӦptzЭ���б��NET_DVR_IPC_PROTO_LIST�õ�
	WORD wDecoderAddress;	/*��������ַ:0 - 255*/
	BYTE bySetPreset[MAX_PRESET_V30];		/* Ԥ�õ��Ƿ�����,0-û������,1-����*/
	BYTE bySetCruise[MAX_CRUISE_V30];		/* Ѳ���Ƿ�����: 0-û������,1-���� */
	BYTE bySetTrack[MAX_TRACK_V30];		    /* �켣�Ƿ�����,0-û������,1-����*/
}NET_DVR_DECODERCFG_V30, *LPNET_DVR_DECODERCFG_V30;

#define DEV_TYPE_NAME_LEN		24      //�豸�������Ƴ���
//DVR�豸����
typedef struct
{
	DWORD dwSize;
	BYTE sDVRName[NAME_LEN];     //DVR����
	DWORD dwDVRID;				//DVR ID,����ң���� //V1.4(0-99), V1.5(0-255)
	DWORD dwRecycleRecord;		//�Ƿ�ѭ��¼��,0:����; 1:��
	//���²��ɸ���
	BYTE sSerialNumber[SERIALNO_LEN];  //���к�
	DWORD dwSoftwareVersion;			//����汾��,��16λ�����汾,��16λ�Ǵΰ汾
	DWORD dwSoftwareBuildDate;			//�����������,0xYYYYMMDD
	DWORD dwDSPSoftwareVersion;		    //DSP����汾,��16λ�����汾,��16λ�Ǵΰ汾
	DWORD dwDSPSoftwareBuildDate;		// DSP�����������,0xYYYYMMDD
	DWORD dwPanelVersion;				// ǰ���汾,��16λ�����汾,��16λ�Ǵΰ汾
	DWORD dwHardwareVersion;	// Ӳ���汾,��16λ�����汾,��16λ�Ǵΰ汾
	BYTE byAlarmInPortNum;		//DVR�����������
	BYTE byAlarmOutPortNum;		//DVR�����������
	BYTE byRS232Num;			//DVR 232���ڸ���
	BYTE byRS485Num;			//DVR 485���ڸ��� 
	BYTE byNetworkPortNum;		//����ڸ���
	BYTE byDiskCtrlNum;			//DVR Ӳ�̿���������
	BYTE byDiskNum;				//DVR Ӳ�̸���
	BYTE byDVRType;				//DVR����, 1:DVR 2:ATM DVR 3:DVS ......
	BYTE byChanNum;				//DVR ͨ������
	BYTE byStartChan;			//��ʼͨ����,����DVS-1,DVR - 1
	BYTE byDecordChans;			//DVR ����·��
	BYTE byVGANum;				//VGA�ڵĸ��� 
	BYTE byUSBNum;				//USB�ڵĸ���
	BYTE byAuxoutNum;			//���ڵĸ���
	BYTE byAudioNum;			//�����ڵĸ���
	BYTE byIPChanNum;			//�������ͨ���� ��8λ����8λ��byHighIPChanNum 
	BYTE byZeroChanNum;			//��ͨ���������
	BYTE bySupport;        //������λ����Ϊ0��ʾ��֧�֣�1��ʾ֧�֣�
	//bySupport & 0x1, ��ʾ�Ƿ�֧����������
	//bySupport & 0x2, ��ʾ�Ƿ�֧�ֱ���
	//bySupport & 0x4, ��ʾ�Ƿ�֧��ѹ������������ȡ
	//bySupport & 0x8, ��ʾ�Ƿ�֧�ֶ�����
	//bySupport & 0x10, ��ʾ֧��Զ��SADP
	//bySupport & 0x20, ��ʾ֧��Raid������
	//bySupport & 0x40, ��ʾ֧��IPSAN����
	//bySupport & 0x80, ��ʾ֧��rtp over rtsp
	BYTE byEsataUseage;		//Esata��Ĭ����;��0-Ĭ�ϱ��ݣ�1-Ĭ��¼��
	BYTE byIPCPlug;			//0-�رռ��弴�ã�1-�򿪼��弴��
	BYTE byStorageMode;		//0-����ģʽ,1-�������, 2��֡ģʽ
	BYTE bySupport1;		//������λ����Ϊ0��ʾ��֧�֣�1��ʾ֧��
	//bySupport1 & 0x1, ��ʾ�Ƿ�֧��snmp v30
	//bySupport1 & 0x2, ֧�����ֻطź�����
	//bySupport1 & 0x4, �Ƿ�֧�ֲ������ȼ�	
	//bySupport1 & 0x8, �����豸�Ƿ�֧�ֲ���ʱ�����չ
	//bySupport1 & 0x10, ��ʾ�Ƿ�֧�ֶ������������33����
	//bySupport1 & 0x20, ��ʾ�Ƿ�֧��rtsp over http	
	WORD wDevType;//�豸�ͺ�
	BYTE  byDevTypeName[DEV_TYPE_NAME_LEN];//�豸�ͺ����� 
	BYTE bySupport2; //��������չ��λ����Ϊ0��ʾ��֧�֣�1��ʾ֧��
	//bySupport2 & 0x1, ��ʾ�Ƿ�֧����չ��OSD�ַ�����(�ն˺�ץ�Ļ���չ����)
	BYTE byAnalogAlarmInPortNum; //ģ�ⱨ���������
	BYTE byStartAlarmInNo;    //ģ�ⱨ��������ʼ��
	BYTE byStartAlarmOutNo;  //ģ�ⱨ�������ʼ��
	BYTE byStartIPAlarmInNo;  //IP����������ʼ��  0-��Ч
	BYTE byStartIPAlarmOutNo; //IP���������ʼ�� 0-��Ч
	BYTE byHighIPChanNum;     //����ͨ����������8λ 
	BYTE byRes2[9];			//����
}NET_DVR_DEVICECFG_V40, *LPNET_DVR_DEVICECFG_V40;

typedef  struct tagNET_DVR_IPSERVER_STREAM
{
	BYTE    byEnable;   // �Ƿ�����
	BYTE    byRes[3];               // �����ֽ�
	NET_DVR_IPADDR struIPServer;    //IPServer ��ַ
	WORD    wPort;                  //IPServer �˿�
	WORD    wDvrNameLen;            // DVR ���Ƴ���
	BYTE    byDVRName[NAME_LEN];    // DVR����
	WORD    wDVRSerialLen;          // ���кų���
	WORD    byRes1[2];              // �����ֽ�
	BYTE    byDVRSerialNumber[SERIALNO_LEN];    // DVR���кų���
	BYTE    byUserName[NAME_LEN];   // DVR ��½�û���
	BYTE    byPassWord[PASSWD_LEN]; // DVR��½����
	BYTE    byChannel;              // DVR ͨ��
	BYTE    byRes2[11];             //  �����ֽ�
}NET_DVR_IPSERVER_STREAM, *LPNET_DVR_IPSERVER_STREAM;

//��ý���������������
typedef struct tagNET_DVR_STREAM_MEDIA_SERVER_CFG
{
	BYTE	byValid;			/*�Ƿ����*/
	BYTE	byRes1[3];
	NET_DVR_IPADDR  struDevIP;      
	WORD	wDevPort;			/*��ý��������˿�*/    
	BYTE	byTransmitType;		/*����Э������ 0-TCP��1-UDP*/
	BYTE	byRes2[69];
}NET_DVR_STREAM_MEDIA_SERVER_CFG,*LPNET_DVR_STREAM_MEDIA_SERVER_CFG;

//�豸ͨ����Ϣ
typedef struct tagNET_DVR_DEV_CHAN_INFO
{
	NET_DVR_IPADDR 	struIP;		    //DVR IP��ַ
	WORD 	wDVRPort;			 	//�˿ں�
	BYTE 	byChannel;				//ͨ����
	BYTE	byTransProtocol;		//����Э������0-TCP��1-UDP
	BYTE	byTransMode;			//��������ģʽ 0�������� 1��������
	BYTE	byFactoryType;			/*ǰ���豸��������,ͨ���ӿڻ�ȡ*/
	BYTE	byDeviceType; //�豸����(��Ƶ�ۺ�ƽ̨���ܰ�ʹ��)��1-����������ʱ������Ƶ�ۺ�ƽ̨��������byVcaSupportChanMode�ֶ���������ʹ�ý���ͨ��������ʾͨ������2-������
	BYTE    byDispChan;//��ʾͨ����,��������ʹ��
	BYTE	bySubDispChan;//��ʾͨ����ͨ���ţ���������ʱʹ��
	BYTE	byResolution;	//; 1-CIF 2-4CIF 3-720P 4-1080P 5-500w����������ʹ�ã���������������ݸò������������Դ
	BYTE	byRes[2];
	BYTE    byDomain[MAX_DOMAIN_NAME];	//�豸����
	BYTE	sUserName[NAME_LEN];	//���������½�ʺ�
	BYTE	sPassword[PASSWD_LEN];	//�����������
}NET_DVR_DEV_CHAN_INFO,*LPNET_DVR_DEV_CHAN_INFO;

//ֱ��ͨ����ý��ȡ��
typedef struct tagNET_DVR_PU_STREAM_CFG
{
	DWORD								dwSize;
	NET_DVR_STREAM_MEDIA_SERVER_CFG	struStreamMediaSvrCfg;
	NET_DVR_DEV_CHAN_INFO				struDevChanInfo;
}NET_DVR_PU_STREAM_CFG,*LPNET_DVR_PU_STREAM_CFG;

typedef struct tagNET_DVR_DDNS_STREAM_CFG
{
	BYTE   byEnable;   // �Ƿ�����
	BYTE   byRes1[3];
	NET_DVR_IPADDR  struStreamServer;            //��ý���������ַ
	WORD   wStreamServerPort;           //��ý��������˿�   
	BYTE   byStreamServerTransmitType;  //��ý�崫��Э������ 0-TCP��1-UDP
	BYTE   byRes2;
	NET_DVR_IPADDR   struIPServer;          //IPSERVER��ַ
	WORD   wIPServerPort;        //IPserver�˿ں�
	BYTE   byRes3[2];           
	BYTE   sDVRName[NAME_LEN];   //DVR����
	WORD   wDVRNameLen;            // DVR���Ƴ���
	WORD   wDVRSerialLen;          // ���кų���
	BYTE   sDVRSerialNumber[SERIALNO_LEN];    // DVR���к�
	BYTE   sUserName[NAME_LEN];   // DVR ��½�û���
	BYTE   sPassWord[PASSWD_LEN]; // DVR��½����
	WORD   wDVRPort;   //DVR�˿ں�
	BYTE   byRes4[2];    
	BYTE   byChannel;              // DVR ͨ��
	BYTE   byTransProtocol; //����Э������0-TCP��1-UDP
	BYTE   byTransMode; //��������ģʽ 0�������� 1��������
	BYTE   byFactoryType; //ǰ���豸��������,ͨ���ӿڻ�ȡ
}NET_DVR_DDNS_STREAM_CFG, *LPNET_DVR_DDNS_STREAM_CFG;

typedef struct tagNET_DVR_PU_STREAM_URL
{
	BYTE    byEnable; 
	BYTE    strURL[240];
	BYTE	byTransPortocol ; // ����Э������ 0-tcp  1-UDP
	WORD    wIPID;  //�豸ID�ţ�wIPID = iDevInfoIndex + iGroupNO*64 +1
	BYTE	byChannel;  //ͨ����
	BYTE    byRes[7];   
}NET_DVR_PU_STREAM_URL, *LPNET_DVR_PU_STREAM_URL;

typedef struct tagNET_DVR_HKDDNS_STREAM
{
	BYTE    byEnable;				 // �Ƿ�����
	BYTE    byRes[3];               // �����ֽ�
	BYTE    byDDNSDomain[64];		// hiDDNS������
	WORD    wPort;                  // hiDDNS �˿�
	WORD    wAliasLen;              // ��������
	BYTE    byAlias[NAME_LEN];		 // ����
	WORD    wDVRSerialLen;          // ���кų���
	BYTE    byRes1[2];              // �����ֽ�
	BYTE    byDVRSerialNumber[SERIALNO_LEN];    // DVR���к�
	BYTE    byUserName[NAME_LEN];   // DVR ��½�û���
	BYTE    byPassWord[PASSWD_LEN]; // DVR��½����
	BYTE    byChannel;              // DVRͨ��
	BYTE    byRes2[11];             // ������	
}NET_DVR_HKDDNS_STREAM, *LPNET_DVR_HKDDNS_STREAM;

typedef struct tagNET_DVR_IPCHANINFO_V40
{
	BYTE    byEnable;				/* ��ͨ���Ƿ����� */
	BYTE    byRes1;
	WORD    wIPID;                  //IP�豸ID
	DWORD 	dwChannel;				//ͨ����
	BYTE	byTransProtocol;		//����Э������0-TCP��1-UDP
	BYTE	byTransMode;			//��������ģʽ 0�������� 1��������
	BYTE	byFactoryType;			/*ǰ���豸��������,ͨ���ӿڻ�ȡ*/
	BYTE	byRes[241];
}NET_DVR_IPCHANINFO_V40,*LPNET_DVR_IPCHANINFO_V40;

typedef union tagNET_DVR_GET_STREAM_UNION
{
	NET_DVR_IPCHANINFO      struChanInfo;	/*IPͨ����Ϣ*/
	NET_DVR_IPSERVER_STREAM struIPServerStream;  // IPServerȥ��
	NET_DVR_PU_STREAM_CFG   struPUStream;     //  ͨ��ǰ���豸��ȡ��ý��ȥ��
	NET_DVR_DDNS_STREAM_CFG struDDNSStream;     //ͨ��IPServer����ý��ȡ��
	NET_DVR_PU_STREAM_URL   struStreamUrl;        //ͨ����ý�嵽urlȡ��
	NET_DVR_HKDDNS_STREAM	struHkDDNSStream;   //ͨ��hiDDNSȥȡ��
	NET_DVR_IPCHANINFO_V40 struIPChan; //ֱ�Ӵ��豸ȡ������չ��
}NET_DVR_GET_STREAM_UNION, *LPNET_DVR_GET_STREAM_UNION;

typedef enum
{
	NET_SDK_IP_DEVICE = 0,
	NET_SDK_STREAM_MEDIA,
	NET_SDK_IPSERVER,
	NET_SDK_DDNS_STREAM_CFG,
	NET_SDK_STREAM_MEDIA_URL,
	NET_SDK_HKDDNS,
	NET_SDK_IP_DEVICE_ADV
}GET_STREAM_TYPE;

typedef struct tagNET_DVR_STREAM_MODE
{
	BYTE    byGetStreamType; //ȡ����ʽGET_STREAM_TYPE��0-ֱ�Ӵ��豸ȡ����1-����ý��ȡ����2-ͨ��IPServer���ip��ַ��ȡ��,3.ͨ��IPServer�ҵ��豸����ͨ����ý��ȥ�豸����
	//4-ͨ����ý����URLȥȡ��,5-ͨ��hkDDNSȡ����6-ֱ�Ӵ��豸ȡ��(��չ)��ʹ��NET_DVR_IPCHANINFO_V40�ṹ
	BYTE    byRes[3];        //�����ֽ�
	NET_DVR_GET_STREAM_UNION uGetStream;    // ��ͬȡ����ʽ�ṹ��
}NET_DVR_STREAM_MODE, *LPNET_DVR_STREAM_MODE;

//��չIP���������豸
typedef struct tagNET_DVR_IPPARACFG_V40
{
	DWORD      dwSize;			                /* �ṹ��С */
	DWORD	   dwGroupNum;					//	 �豸֧�ֵ�������    
	DWORD      dwAChanNum;					//���ģ��ͨ������
	DWORD      dwDChanNum;                  //����ͨ������
	DWORD      dwStartDChan;		            //��ʼ����ͨ��
	BYTE       byAnalogChanEnable[MAX_CHANNUM_V30];    /* ģ��ͨ���Ƿ����ã��ӵ͵��߱�ʾ1-64ͨ����0��ʾ��Ч 1��Ч */
	NET_DVR_IPDEVINFO_V31   struIPDevInfo[MAX_IP_DEVICE_V40];      /* IP�豸 */
	NET_DVR_STREAM_MODE  struStreamMode[MAX_CHANNUM_V30];
	BYTE            byRes2[20];                 // �����ֽ�
}NET_DVR_IPPARACFG_V40, *LPNET_DVR_IPPARACFG_V40;

//ntp
typedef struct 
{
	BYTE sNTPServer[64];   /* Domain Name or IP addr of NTP server */
	WORD wInterval;		 /* adjust time interval(hours) */
	BYTE byEnableNTP;    /* enable NPT client 0-no��1-yes*/
	signed char cTimeDifferenceH; /* ����ʱ�׼ʱ��� Сʱƫ��-12 ... +13 */
	signed char cTimeDifferenceM;/* ����ʱ�׼ʱ��� ����ƫ��0, 30, 45*/
	BYTE res1;
	WORD wNtpPort;         /* ntp server port 9000���� �豸Ĭ��Ϊ123*/
	BYTE res2[8];
}NET_DVR_NTPPARA, *LPNET_DVR_NTPPARA;

//ʱ���¼���������(�ӽṹ)
typedef struct 
{
	NET_DVR_SCHEDTIME struRecordTime;
	BYTE byRecordType;	//0:��ʱ¼��1:�ƶ���⣬2:����¼��3:����|������4:����&����, 5:�����, 6: ����¼��,10-PIR������11-���߱�����12-���ȱ�����13-���б���,14-���ܽ�ͨ�¼���15Խ����⣬16����������⣬17��Ƶ�쳣���
	char reservedData[3];
}NET_DVR_RECORDSCHED, *LPNET_DVR_RECORDSCHED;

//ȫ��¼���������(�ӽṹ)
typedef struct 
{
	WORD wAllDayRecord;				/* �Ƿ�ȫ��¼�� 0-�� 1-��*/
	BYTE byRecordType;				/* ¼������ 0:��ʱ¼��1:�ƶ���⣬2:����¼��3:����|������4:����&���� 5:�����, 6: ����¼��,10-PIR������11-���߱�����12-���ȱ�����13-�ƶ�|��������|PIR|���߱���|���ȱ���,14-���ܽ�ͨ�¼�,15-Խ�����,16-��������,17-�����쳣,18-����������,19-������⣨Խ�����|��������|��������|�뿪����|����ʶ��*/
	char reservedData;
}NET_DVR_RECORDDAY, *LPNET_DVR_RECORDDAY;

//ͨ��¼���������(9000��չ)
typedef struct 
{
	DWORD	dwSize;
	DWORD	dwRecord;  						/*�Ƿ�¼�� 0-�� 1-��*/
	NET_DVR_RECORDDAY	struRecAllDay[MAX_DAYS];
	NET_DVR_RECORDSCHED	struRecordSched[MAX_DAYS][MAX_TIMESEGMENT_V30];
	DWORD	dwRecordTime;					/* ¼����ʱ���� 0-5�룬 1-10�룬 2-30�룬 3-1���ӣ� 4-2���ӣ� 5-5���ӣ� 6-10����*/
	DWORD	dwPreRecordTime;				/* Ԥ¼ʱ�� 0-��Ԥ¼ 1-5�� 2-10�� 3-15�� 4-20�� 5-25�� 6-30�� 7-0xffffffff(������Ԥ¼) */
	DWORD	dwRecorderDuration;				/* ¼�񱣴���ʱ�� */
	BYTE	byRedundancyRec;	/*�Ƿ�����¼��,��Ҫ����˫���ݣ�0/1*/
	BYTE	byAudioRec;		/*¼��ʱ����������ʱ�Ƿ��¼��Ƶ���ݣ������д˷���*/
	BYTE	byStreamType;  // 0:������ 1��������
	BYTE	byPassbackRecord;  // 0:���ش�¼�� 1���ش�¼��
	WORD	wLockDuration;  // ¼������ʱ������λСʱ 0��ʾ��������0xffff��ʾ����������¼��ε�ʱ�����������ĳ���ʱ����¼�񣬽���������
	BYTE	byRecordBackup;  // 0:¼�񲻴浵 1��¼��浵
	BYTE 	bySVCLevel;	//SVC��֡���ͣ�0-���飬1-�����֮һ 2-���ķ�֮��
	BYTE	byReserve[4]; 
}NET_DVR_RECORD_V30, *LPNET_DVR_RECORD_V30;

//��Ƶ��������
typedef struct tagNET_DVR_VIDEOEFFECT
{
	BYTE byBrightnessLevel; /*0-100*/
	BYTE byContrastLevel; /*0-100*/
	BYTE bySharpnessLevel; /*0-100*/
	BYTE bySaturationLevel; /*0-100*/
	BYTE byHueLevel; /*0-100,��������*/
	BYTE byEnableFunc; //ʹ�ܣ���λ��ʾ��bit0-SMART IR(������)��bit1-���ն�,bit2-ǿ������ʹ�ܣ�0-��1-��
	BYTE byLightInhibitLevel; //ǿ�����Ƶȼ���[1-3]��ʾ�ȼ�
	BYTE byGrayLevel; //�Ҷ�ֵ��0-[0-255]��1-[16-235]
}NET_DVR_VIDEOEFFECT, *LPNET_DVR_VIDEOEFFECT;

//wifi����״̬
typedef	 struct  tagNET_DVR_WIFI_CONNECT_STATUS
{
	DWORD		dwSize;
	BYTE		byCurStatus;	//1-�����ӣ�2-δ���ӣ�3-��������
	BYTE		byRes1[3];		//����
	DWORD		dwErrorCode;	// byCurStatus = 2ʱ��Ч,1-�û������������,2-�޴�·����,3-δ֪����
	BYTE		byRes[244];
}NET_DVR_WIFI_CONNECT_STATUS,*LPNET_DVR_WIFI_CONNECT_STATUS;

//��ͨ��ѹ�����ò���
typedef struct tagNET_DVR_ZEROCHANCFG
{
	DWORD dwSize;			//�ṹ����
	BYTE  byEnable;			//0-ֹͣ��ͨ�����룬1-��ʾ������ͨ������
	BYTE  byRes1[3];			//����
	DWORD dwVideoBitrate; 	//��Ƶ���� 0-���� 1-16K(����) 2-32K 3-48k 4-64K 5-80K 6-96K 7-128K 8-160k 9-192K 10-224K 11-256K 12-320K
	// 13-384K 14-448K 15-512K 16-640K 17-768K 18-896K 19-1024K 20-1280K 21-1536K 22-1792K 23-2048K
	//���λ(31λ)�ó�1��ʾ���Զ�������, 0-30λ��ʾ����ֵ(MIN-32K MAX-8192K)��
	DWORD dwVideoFrameRate;	//֡�� 0-ȫ��; 1-1/16; 2-1/8; 3-1/4; 4-1/2; 5-1; 6-2; 7-4; 8-6; 9-8; 10-10; 11-12; 12-16; 13-20, //V2.0����14-15, 15-18, 16-22;
	BYTE  byRes2[32];        //����
}NET_DVR_ZEROCHANCFG, *LPNET_DVR_ZEROCHANCFG;

#define MAX_AUX_ALARM_NUM 8 //�������������
#define MAX_WIRELESS_ALARM_NUM 8 //������߱�������
typedef enum _IPC_AUX_ALARM_TYPE_
{
	IPC_AUXALARM_UNKNOW = 0, //δ֪
	IPC_AUXALARM_PIR = 1, //PIR����
	IPC_AUXALARM_WIRELESS = 2,   //���߱���
	IPC_AUXALARM_CALLHELP = 3  //���ȱ���
}IPC_AUX_ALARM_TYPE;

typedef struct tagNET_IPC_PIR_ALARMCFG_EX
{
	BYTE byAlarmName[NAME_LEN];	/* �������� */
	BYTE byAlarmHandle;	        /* �Ƿ��� 0-������ 1-����*/
	BYTE byRes1[3];			
	NET_DVR_HANDLEEXCEPTION_V30 struAlarmHandleType;	/* ����ʽ */	
	BYTE byRelRecordChan[MAX_CHANNUM_V30]; //����������¼��ͨ��,Ϊ1��ʾ������ͨ��
	NET_DVR_SCHEDTIME   struAlarmTime[MAX_DAYS][MAX_TIMESEGMENT_V30];
	BYTE byRes[1464];
}NET_IPC_PIR_ALARMCFG_EX, *LPNET_IPC_PIR_ALARMCFG_EX;

//���ȱ���
typedef struct tagNET_IPC_CALLHELP_ALARMCFG
{
	BYTE byAlarmHandle;	        /* �Ƿ��� 0-������ 1-����*/
	BYTE byRes1[3];			
	NET_DVR_HANDLEEXCEPTION_V30 struAlarmHandleType;	/* ����ʽ */	
	BYTE byRelRecordChan[MAX_CHANNUM_V30]; //����������¼��ͨ��,Ϊ1��ʾ������ͨ��
	BYTE byRes[64];
}NET_IPC_CALLHELP_ALARMCFG, *LPNET_IPC_CALLHELP_ALARMCFG;

typedef struct tagNET_IPC_SINGLE_WIRELESS_ALARMCFG
{
	BYTE byAlarmName[NAME_LEN];	/* �������� */
	BYTE byAlarmHandle;	        /* �Ƿ��� 0-������ 1-����*/
	BYTE byID; //���߱���ID��1-8
	BYTE byRes1[2];			
	NET_DVR_HANDLEEXCEPTION_V30 struAlarmHandleType;	/* ����ʽ */
	BYTE byRelRecordChan[MAX_CHANNUM_V30]; //����������¼��ͨ��,Ϊ1��ʾ������ͨ��	
	BYTE byRes[32];
}NET_IPC_SINGLE_WIRELESS_ALARMCFG, *LPNET_IPC_SINGLE_WIRELESS_ALARMCFG;

typedef struct tagNET_IPC_WIRELESS_ALARMCFG
{
	NET_IPC_SINGLE_WIRELESS_ALARMCFG struWirelessAlarm[MAX_WIRELESS_ALARM_NUM]; //�������߱�������
	BYTE byRes[32];
}NET_IPC_WIRELESS_ALARMCFG, *LPNET_IPC_WIRELESS_ALARMCFG;

typedef union tagNET_IPC_AUX_ALARMCFG_UNION
{
	DWORD uLen[472];
	NET_IPC_PIR_ALARMCFG_EX struPIRAlarm; //PIR��������
	NET_IPC_WIRELESS_ALARMCFG struWirelessAlarm; //���߱�������
	NET_IPC_CALLHELP_ALARMCFG struCallHelpAlarm; //���ȱ�������
}NET_IPC_AUX_ALARMCFG_UNION, *LPNET_IPC_AUX_ALARMCFG_UNION;

typedef struct tagNET_IPC_SINGLE_AUX_ALARMCFG
{
	BYTE byAlarmType;	   //���������ͣ����IPC_AUX_ALARM_TYPE
	BYTE byRes1[3];			
	NET_IPC_AUX_ALARMCFG_UNION uAlarm; //��������
	BYTE byRes[16];
}NET_IPC_SINGLE_AUX_ALARMCFG, *LPNET_IPC_SINGLE_AUX_ALARMCFG;

typedef struct tagNET_IPC_AUX_ALARMCFG
{
	DWORD dwSize;
	NET_IPC_SINGLE_AUX_ALARMCFG struAlarm[MAX_AUX_ALARM_NUM]; //��������
	BYTE byRes[64];
}NET_IPC_AUX_ALARMCFG, *LPNET_IPC_AUX_ALARMCFG;
/********************************SDK�ӿ�*********************************/
//��ʼ��
NET_DVR_API BOOL __stdcall NET_DVR_Init();
NET_DVR_API BOOL __stdcall NET_DVR_Cleanup();


NET_DVR_API BOOL __stdcall NET_DVR_SetConnectTime(DWORD dwWaitTime = 5000, DWORD dwTryTimes = 3);
NET_DVR_API BOOL __stdcall NET_DVR_SetReconnect(DWORD dwInterval = 30000, BOOL bEnableRecon = TRUE);

//��ȡSDK�汾
NET_DVR_API DWORD __stdcall NET_DVR_GetSDKVersion();
NET_DVR_API DWORD __stdcall NET_DVR_GetSDKBuildVersion();

//������Ϣ�ص�
NET_DVR_API BOOL __stdcall NET_DVR_SetExceptionCallBack_V30(UINT reserved1, void* reserved2, void (CALLBACK* fExceptionCallBack)(DWORD dwType, LONG lUserID, LONG lHandle, void *pUser), void *pUser);

//��½ע��
NET_DVR_API LONG __stdcall NET_DVR_Login_V30(char *sDVRIP, WORD wDVRPort, char *sUserName, char *sPassword, LPNET_DVR_DEVICEINFO_V30 lpDeviceInfo);
NET_DVR_API BOOL __stdcall NET_DVR_Logout_V30(LONG lUserID);
NET_DVR_API BOOL __stdcall NET_DVR_Logout(LONG lUserID);

//��ȡ������Ϣ
NET_DVR_API DWORD __stdcall NET_DVR_GetLastError();
NET_DVR_API char* __stdcall NET_DVR_GetErrorMsg(LONG *pErrorNo = NULL);

//Ԥ��
typedef void (CALLBACK *REALDATACALLBACK) (LONG lPlayHandle, DWORD dwDataType, BYTE *pBuffer, DWORD dwBufSize, void* pUser);
NET_DVR_API LONG __stdcall NET_DVR_RealPlay_V30(LONG lUserID, LPNET_DVR_CLIENTINFO lpClientInfo, void(CALLBACK *fRealDataCallBack_V30) (LONG lRealHandle, DWORD dwDataType, BYTE *pBuffer, DWORD dwBufSize, void* pUser) = NULL, void* pUser = NULL, BOOL bBlocked = FALSE);
NET_DVR_API BOOL __stdcall NET_DVR_StopRealPlay(LONG lRealHandle);
NET_DVR_API BOOL __stdcall NET_DVR_SaveRealData(LONG lRealHandle,char *sFileName);
NET_DVR_API BOOL __stdcall NET_DVR_StopSaveRealData(LONG lRealHandle);
NET_DVR_API LONG __stdcall NET_DVR_ZeroStartPlay(LONG lUserID, LPNET_DVR_CLIENTINFO lpClientInfo, REALDATACALLBACK fRealDataCallBack_V30 = NULL, void* pUser = NULL, BOOL bBlocked = TRUE);
NET_DVR_API BOOL __stdcall NET_DVR_ZeroStopPlay(LONG lPlayHandle);


//��������ǿ��I֡
NET_DVR_API BOOL __stdcall NET_DVR_MakeKeyFrame(LONG lUserID, LONG lChannel);
NET_DVR_API BOOL __stdcall NET_DVR_MakeKeyFrameSub(LONG lUserID, LONG lChannel);

//��ƵЧ������
NET_DVR_API BOOL __stdcall NET_DVR_ClientSetVideoEffect(LONG lRealHandle,DWORD dwBrightValue,DWORD dwContrastValue, DWORD dwSaturationValue,DWORD dwHueValue);
NET_DVR_API BOOL __stdcall NET_DVR_ClientGetVideoEffect(LONG lRealHandle,DWORD *pBrightValue,DWORD *pContrastValue, DWORD *pSaturationValue,DWORD *pHueValue);

//��������
NET_DVR_API BOOL __stdcall NET_DVR_RebootDVR(LONG lUserID);
NET_DVR_API BOOL __stdcall NET_DVR_ShutDownDVR(LONG lUserID);
//Զ�̿����豸���ֶ�¼��
NET_DVR_API BOOL __stdcall NET_DVR_StartDVRRecord(LONG lUserID,LONG lChannel,LONG lRecordType);
NET_DVR_API BOOL __stdcall NET_DVR_StopDVRRecord(LONG lUserID,LONG lChannel);
//�������ձ�����Ϣ
NET_DVR_API LONG __stdcall NET_DVR_SetupAlarmChan_V30(LONG lUserID);
NET_DVR_API BOOL __stdcall NET_DVR_CloseAlarmChan_V30(LONG lAlarmHandle);	
typedef void (CALLBACK *MSGCallBack)(LONG lCommand, NET_DVR_ALARMER *pAlarmer, char *pAlarmInfo, DWORD dwBufLen, void* pUser);
NET_DVR_API BOOL __stdcall NET_DVR_SetDVRMessageCallBack_V30(MSGCallBack fMessageCallBack, void* pUser);
	
//PTZ����
NET_DVR_API BOOL __stdcall NET_DVR_PTZControl(LONG lRealHandle,DWORD dwPTZCommand,DWORD dwStop);
NET_DVR_API BOOL __stdcall NET_DVR_PTZControl_Other(LONG lUserID,LONG lChannel,DWORD dwPTZCommand,DWORD dwStop);
NET_DVR_API BOOL __stdcall NET_DVR_PTZPreset(LONG lRealHandle,DWORD dwPTZPresetCmd,DWORD dwPresetIndex);
NET_DVR_API BOOL __stdcall NET_DVR_PTZPreset_Other(LONG lUserID,LONG lChannel,DWORD dwPTZPresetCmd,DWORD dwPresetIndex);
NET_DVR_API BOOL __stdcall NET_DVR_PTZControl_EX(LONG lRealHandle,DWORD dwPTZCommand,DWORD dwStop);
NET_DVR_API BOOL __stdcall NET_DVR_PTZPreset_EX(LONG lRealHandle,DWORD dwPTZPresetCmd,DWORD dwPresetIndex);
NET_DVR_API BOOL __stdcall NET_DVR_PTZCruise(LONG lRealHandle,DWORD dwPTZCruiseCmd,BYTE byCruiseRoute, BYTE byCruisePoint, WORD wInput);
NET_DVR_API BOOL __stdcall NET_DVR_PTZCruise_Other(LONG lUserID,LONG lChannel,DWORD dwPTZCruiseCmd,BYTE byCruiseRoute, BYTE byCruisePoint, WORD wInput);
NET_DVR_API BOOL __stdcall NET_DVR_PTZCruise_EX(LONG lRealHandle,DWORD dwPTZCruiseCmd,BYTE byCruiseRoute, BYTE byCruisePoint, WORD wInput);
NET_DVR_API BOOL __stdcall NET_DVR_PTZTrack(LONG lRealHandle, DWORD dwPTZTrackCmd);
NET_DVR_API BOOL __stdcall NET_DVR_PTZTrack_Other(LONG lUserID, LONG lChannel, DWORD dwPTZTrackCmd);
NET_DVR_API BOOL __stdcall NET_DVR_PTZTrack_EX(LONG lRealHandle, DWORD dwPTZTrackCmd);
NET_DVR_API BOOL __stdcall NET_DVR_PTZControlWithSpeed(LONG lRealHandle, DWORD dwPTZCommand, DWORD dwStop, DWORD dwSpeed);
NET_DVR_API BOOL __stdcall NET_DVR_PTZControlWithSpeed_Other(LONG lUserID, LONG lChannel, DWORD dwPTZCommand, DWORD dwStop, DWORD dwSpeed);
NET_DVR_API BOOL __stdcall NET_DVR_PTZControlWithSpeed_EX(LONG lRealHandle, DWORD dwPTZCommand, DWORD dwStop, DWORD dwSpeed);

NET_DVR_API BOOL __stdcall NET_DVR_GetPTZProtocol(LONG lUserID, NET_DVR_PTZCFG *pPtzcfg);

//��̨ͼ������ѡ��Ŵ����С
NET_DVR_API BOOL __stdcall NET_DVR_PTZSelZoomIn(LONG lRealHandle, LPNET_DVR_POINT_FRAME pStruPointFrame);
NET_DVR_API BOOL __stdcall NET_DVR_PTZSelZoomIn_EX(LONG lUserID, LONG lChannel, LPNET_DVR_POINT_FRAME pStruPointFrame);

//����ת��
NET_DVR_API LONG __stdcall NET_DVR_StartVoiceCom_MR_V30(LONG lUserID, DWORD dwVoiceChan, void(CALLBACK *fVoiceDataCallBack)(LONG lVoiceComHandle, char *pRecvDataBuffer, DWORD dwBufSize, BYTE byAudioFlag, void* pUser), void* pUser);
NET_DVR_API BOOL __stdcall NET_DVR_VoiceComSendData(LONG lVoiceComHandle, char *pSendBuf, DWORD dwBufSize);
NET_DVR_API BOOL __stdcall NET_DVR_StopVoiceCom(LONG lVoiceComHandle);
NET_DVR_API BOOL __stdcall NET_DVR_GetCurrentAudioCompress(LONG lUserID, LPNET_DVR_COMPRESSION_AUDIO lpCompressAudio);

//�����������
NET_DVR_API BOOL __stdcall NET_DVR_GetAlarmOut_V30(LONG lUserID, LPNET_DVR_ALARMOUTSTATUS_V30 lpAlarmOutState);
NET_DVR_API BOOL __stdcall NET_DVR_SetAlarmOut(LONG lUserID, LONG lAlarmOutPort,LONG lAlarmOutStatic);

//��������
#define NET_DVR_GET_DEVICECFG		    100	
#define NET_DVR_SET_DEVICECFG		    101
#define NET_DVR_GET_DEVICECFG_V40		1100

#define NET_DVR_GET_TIMECFG				118
#define NET_DVR_SET_TIMECFG				119

#define NET_DVR_GET_NTPCFG				224
#define NET_DVR_SET_NTPCFG				225

#define NET_DVR_GET_AP_INFO_LIST		305
#define NET_DVR_SET_WIFI_CFG			306
#define NET_DVR_GET_WIFI_CFG			307
#define NET_DVR_GET_WIFI_STATUS			310

#define NET_DVR_GET_NETCFG_V30		    1000
#define NET_DVR_SET_NETCFG_V30		    1001

#define NET_DVR_GET_PICCFG_V30		    1002
#define NET_DVR_SET_PICCFG_V30		    1003

#define NET_DVR_GET_RECORDCFG_V30		1004
#define NET_DVR_SET_RECORDCFG_V30		1005

#define NET_DVR_GET_ALARMINCFG_V30		1024
#define NET_DVR_SET_ALARMINCFG_V30		1025
#define NET_DVR_GET_ALARMOUTCFG_V30		1026
#define NET_DVR_SET_ALARMOUTCFG_V30		1027

#define NET_DVR_GET_COMPRESSCFG_V30	    1040
#define NET_DVR_SET_COMPRESSCFG_V30	    1041

#define NET_DVR_GET_DECODERCFG_V30		1042
#define NET_DVR_SET_DECODERCFG_V30		1043

#define NET_DVR_GET_IPALARMOUTCFG       1052

#define NET_DVR_GET_COMPRESSCFG_AUD		1058

#define NET_DVR_GET_IPPARACFG_V31       1060
#define NET_DVR_SET_IPPARACFG_V31       1061
#define NET_DVR_GET_IPPARACFG_V40		1062
#define NET_DVR_SET_IPPARACFG_V40		1063

#define NET_DVR_GET_ZEROCHANCFG			1102
#define NET_DVR_SET_ZEROCHANCFG			1103

#define NET_IPC_GET_AUX_ALARMCFG		3209
#define NET_IPC_SET_AUX_ALARMCFG		3210


NET_DVR_API BOOL __stdcall NET_DVR_GetDVRConfig(LONG lUserID, DWORD dwCommand,LONG lChannel, LPVOID lpOutBuffer, DWORD dwOutBufferSize, LPDWORD lpBytesReturned);
NET_DVR_API BOOL __stdcall NET_DVR_SetDVRConfig(LONG lUserID, DWORD dwCommand,LONG lChannel, LPVOID lpInBuffer, DWORD dwInBufferSize);

NET_DVR_API BOOL __stdcall NET_DVR_GetDVRWorkState_V30(LONG lUserID, LPNET_DVR_WORKSTATE_V30 lpWorkState);

NET_DVR_API BOOL __stdcall NET_DVR_GetUpnpNatState(LONG lUserID, LPNET_DVR_UPNP_NAT_STATE lpState);
//�ļ�����
NET_DVR_API LONG __stdcall NET_DVR_FindFile_V30(LONG lUserID, NET_DVR_FILECOND *pFindCond);
NET_DVR_API LONG __stdcall NET_DVR_FindNextFile_V30(LONG lFindHandle, LPNET_DVR_FINDDATA_V30 lpFindData);
NET_DVR_API BOOL  __stdcall NET_DVR_FindClose_V30(LONG lFindHandle);

//�ļ��ط�����
NET_DVR_API LONG __stdcall NET_DVR_PlayBackByName(LONG lUserID,char *sPlayBackFileName, HWND hWnd);
NET_DVR_API LONG __stdcall NET_DVR_PlayBackByTime(LONG lUserID,LONG lChannel, LPNET_DVR_TIME lpStartTime, LPNET_DVR_TIME lpStopTime, HWND hWnd);
NET_DVR_API LONG __stdcall NET_DVR_GetFileByName(LONG lUserID,char *sDVRFileName,char *sSavedFileName);
NET_DVR_API LONG __stdcall NET_DVR_GetFileByTime(LONG lUserID,LONG lChannel, LPNET_DVR_TIME lpStartTime, LPNET_DVR_TIME lpStopTime, char *sSavedFileName);
NET_DVR_API BOOL  __stdcall NET_DVR_StopGetFile(LONG lFileHandle);
NET_DVR_API LONG __stdcall NET_DVR_GetDownloadPos(LONG lFileHandle);
NET_DVR_API LONG __stdcall NET_DVR_GetPlayBackPos(LONG lPlayHandle);
NET_DVR_API BOOL __stdcall NET_DVR_StopPlayBack(LONG lPlayHandle);
NET_DVR_API BOOL __stdcall NET_DVR_SetPlayDataCallBack_V40(LONG lPlayHandle,void(CALLBACK *fPlayDataCallBack_V40) (LONG lPlayHandle, DWORD dwDataType, BYTE *pBuffer,DWORD dwBufSize,void *pUser),void *pUser);
NET_DVR_API BOOL __stdcall NET_DVR_PlayBackControl_V40(LONG lPlayHandle,DWORD dwControlCode, LPVOID lpInBuffer = NULL, DWORD dwInLen = 0, LPVOID lpOutBuffer = NULL, DWORD *lpOutLen = NULL);
NET_DVR_API BOOL __stdcall NET_DVR_PlayBackSaveData(LONG lPlayHandle,char *sFileName);
NET_DVR_API BOOL __stdcall NET_DVR_StopPlayBackSave(LONG lPlayHandle);

//IP Server
NET_DVR_API BOOL  __stdcall NET_DVR_GetDVRIPByResolveSvr_EX(char *sServerIP, WORD wServerPort, unsigned char *sDVRName, WORD wDVRNameLen, BYTE *sDVRSerialNumber, WORD wDVRSerialLen, char* sGetIP, DWORD *dwPort);

//JPEGץͼ
NET_DVR_API BOOL __stdcall NET_DVR_CaptureJPEGPicture(LONG lUserID, LONG lChannel, LPNET_DVR_JPEGPARA lpJpegPara, char *sPicFileName);
NET_DVR_API BOOL __stdcall NET_DVR_CaptureJPEGPicture_NEW(LONG lUserID, LONG lChannel, LPNET_DVR_JPEGPARA lpJpegPara, char *sJpegPicBuffer, DWORD dwPicSize,  LPDWORD lpSizeReturned);

//������־�ļ�д��ӿ�
NET_DVR_API BOOL __stdcall NET_DVR_SetLogToFile(DWORD nLogLevel = 0, char * strLogDir = NULL, BOOL bAutoDel = TRUE);

//͸��ͨ������
NET_DVR_API LONG __stdcall NET_DVR_SerialStart(LONG lUserID,LONG lSerialPort,void(CALLBACK *fSerialDataCallBack)(LONG lSerialHandle,char *pRecvDataBuffer,DWORD dwBufSize,DWORD dwUser),DWORD dwUser);
//485��Ϊ͸��ͨ��ʱ����Ҫָ��ͨ���ţ���Ϊ��ͬͨ����485�����ÿ��Բ�ͬ(���粨����)
NET_DVR_API BOOL __stdcall NET_DVR_SerialSend(LONG lSerialHandle, LONG lChannel, char *pSendBuf,DWORD dwBufSize);
NET_DVR_API BOOL __stdcall NET_DVR_SerialStop(LONG lSerialHandle);
NET_DVR_API BOOL __stdcall NET_DVR_SendTo232Port(LONG lUserID, char *pSendBuf, DWORD dwBufSize);
NET_DVR_API BOOL __stdcall NET_DVR_SendToSerialPort(LONG lUserID, DWORD dwSerialPort, DWORD dwSerialIndex, char *pSendBuf, DWORD dwBufSize);
//SDK��������
NET_DVR_API BOOL __stdcall NET_DVR_SetSDKLocalConfig(LPNET_DVR_SDKLOCAL_CFG lpSdkLocalCfg);
NET_DVR_API BOOL __stdcall NET_DVR_GetSDKLocalConfig(LPNET_DVR_SDKLOCAL_CFG lpSdkLocalCfg);
NET_DVR_API BOOL  __stdcall NET_DVR_SetRecvTimeOut(DWORD nRecvTimeOut = 5000); //��С3000����
//����
NET_DVR_API LONG __stdcall NET_DVR_Upgrade(LONG lUserID, char *sFileName);
NET_DVR_API int __stdcall NET_DVR_GetUpgradeState(LONG lUpgradeHandle);
NET_DVR_API int __stdcall NET_DVR_GetUpgradeProgress(LONG lUpgradeHandle);
NET_DVR_API LONG __stdcall NET_DVR_GetUpgradeStep(LONG lUpgradeHandle, LONG *pSubProgress);
NET_DVR_API BOOL __stdcall NET_DVR_CloseUpgradeHandle(LONG lUpgradeHandle);
NET_DVR_API BOOL __stdcall NET_DVR_SetNetworkEnvironment(DWORD dwEnvironmentLevel);

#ifdef __cplusplus
}
#endif

#endif 

