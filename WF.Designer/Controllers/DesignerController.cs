﻿using OptimaJet.Workflow;
using OptimaJet.Workflow.Core.Builder;
using OptimaJet.Workflow.Core.Bus;
using OptimaJet.Workflow.Core.Runtime;
using System;
using System.Collections.Specialized;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using System.Xml.Linq;
using WorkflowRuntime = OptimaJet.Workflow.Core.Runtime.WorkflowRuntime;

namespace WF.Designer.Controllers
{
    public class DesignerController : Controller
    {
        public ActionResult Index(string schemeName)
        {
            return View();
        }

        public ActionResult API()
        {
            Stream filestream = null;
            if (Request.Files.Count > 0)
            {
                filestream = Request.Files[0].InputStream;
            }                

            var pars = new NameValueCollection();
            pars.Add(Request.Params);

            if (Request.HttpMethod.Equals("POST", StringComparison.InvariantCultureIgnoreCase))
            {
                var parsKeys = pars.AllKeys;
                foreach (var key in Request.Form.AllKeys)
                {
                    if (!parsKeys.Contains(key))
                    {
                        pars.Add(Request.Form);
                    }
                }
            }

            var res = getRuntime.DesignerAPI(pars, filestream, true);
            if (pars["operation"].ToLower() == "downloadscheme")
            {
                return File(Encoding.UTF8.GetBytes(res), "text/xml", "Scheme.xml");
            }

            return Content(res);
        }

        private static volatile WorkflowRuntime _runtime;
        private static readonly object _sync = new object();
        private WorkflowRuntime getRuntime
        {
            get
            {
                if (_runtime == null)
                {
                    lock (_sync)
                    {
                        if (_runtime == null)
                        {
                            var connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                            var builder = new WorkflowBuilder<XElement>(
                                new OptimaJet.Workflow.DbPersistence.DbXmlWorkflowGenerator(connectionString),
                                new OptimaJet.Workflow.Core.Parser.XmlWorkflowParser(),
                                new OptimaJet.Workflow.DbPersistence.DbSchemePersistenceProvider(connectionString)
                                ).WithDefaultCache();
                            _runtime = new WorkflowRuntime(new Guid("{8D38DB8F-F3D5-4F26-A989-4FDD40F32D9D}"))
                                .WithBuilder(builder)
                                .WithPersistenceProvider(new OptimaJet.Workflow.DbPersistence.DbPersistenceProvider(connectionString))
                                .WithTimerManager(new TimerManager())
                                .WithBus(new NullBus())
                                .SwitchAutoUpdateSchemeBeforeGetAvailableCommandsOn()
                                .Start();
                        }
                    }
                }

                return _runtime;
            }
        }
    }
}